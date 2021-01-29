/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen.protocol.railsjson.generators;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.pattern.SmithyPattern;
import software.amazon.smithy.model.shapes.*;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpLabelTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.HttpTrait;
import software.amazon.smithy.model.traits.RequiredTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class BuilderGenerator {

    private final RubySettings settings;
    private final Model model;
    private final Set<ShapeId> generatedBuilders;

    public BuilderGenerator(RubySettings settings, Model model) {
        this.settings = settings;
        this.model = model;
        this.generatedBuilders = new HashSet<>();
    }

    public void render(FileManifest fileManifest) {
        RubyCodeWriter writer = new RubyCodeWriter();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Builders")
                .call(() -> renderBuilders(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/builders.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderBuilders(RubyCodeWriter writer) {
        Stream<OperationShape> operations = model.shapes(OperationShape.class);
        operations.forEach(o -> renderBuildersForOperation(writer, o));
    }

    private void renderBuildersForOperation(RubyCodeWriter writer, OperationShape operation) {
        //TODO: An optional check on the Output Type being present
        ShapeId inputShapeId = operation.getInput().get();

        System.out.println("Generating builders for Operation: " + operation.getId());
        HttpTrait httpTrait = operation.expectTrait(HttpTrait.class);
        Shape inputShape = model.expectShape(inputShapeId);

        writer
                .openBlock("class $LOperation", operation.getId().getName())
                .openBlock("def self.build(http_req:, params:)")
                .write("http_req.http_method = '$L'", httpTrait.getMethod())
                .call(() -> renderUriBuilder(writer, operation, inputShape))
                .call(() -> renderQueryParamsBuilder(writer, operation, inputShape))
                .call(() -> renderHeadersBuilder(writer, operation, inputShape))
                .call(() -> renderOperationBodyBuilder(writer, operation, inputShape))
                .closeBlock("end")
                .closeBlock("end");

        generatedBuilders.add(operation.toShapeId());

        for (Iterator<Shape> it = new Walker(model).iterateShapes(inputShape); it.hasNext(); ) {
            Shape s = it.next();
            if (!generatedBuilders.contains(s.getId())) {
                if (s.isStructureShape()) {
                    renderBuilderForStructure(writer, s.asStructureShape().get());
                } else if (s.isListShape()) {
                    renderBuilderForList(writer, s.asListShape().get());
                } else {
                    System.out.println("\tSkipping " + s.getId() + " it is not a structure.  Type = " + s.getType());
                }
            } else {
                System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
            }

        }
    }

    private void renderOperationBodyBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        //determine if there are any members of the input that need to be serialized to the body
        boolean serializeBody = inputShape.members().stream().anyMatch((m) -> !m.hasTrait(HttpLabelTrait.class) && !m.hasTrait(HttpQueryTrait.class) && !m.hasTrait((HttpHeaderTrait.class)));
        if (serializeBody) {
            writer
                    .write("json = Builders::$L.build(params)", inputShape.getId().getName())
                    .write("http_req.body = StringIO.new(JSON.dump(json))");
        }
    }

    private void renderQueryParamsBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> queryMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpQueryTrait.class))
                .collect(Collectors.toList());
        System.out.println("\tQUERY BUILDER: " + operation.getId() + " has " + queryMembers.size() + " query params...");

        for(MemberShape m : queryMembers) {
            HttpQueryTrait queryTrait = m.expectTrait(HttpQueryTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding query params for: " + queryTrait.getValue() + " -> " + target.getId());
            String symbolName =  RubyFormatter.asSymbol(m.getMemberName());
            // TODO: Handle required
            writer.write("http_req.append_query_param('$1L', params[$2L].to_str) if params.key?($2L)", queryTrait.getValue(), symbolName);
        }
    }

    private void renderHeadersBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> headerMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());
        System.out.println("\tHEADER BUILDER: " + operation.getId() + " has " + headerMembers.size() + " query params...");

        for(MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding headers for: " + headerTrait.getValue() + " -> " + target.getId());
            String symbolName =  RubyFormatter.asSymbol(m.getMemberName());
            // TODO: Handle required
            writer.write("http_req.headers['$1L'] = params[$2L].to_str if params.key?($2L)", headerTrait.getValue(), symbolName);
        }
    }

    private void renderUriBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        HttpTrait httpTrait = operation.expectTrait(HttpTrait.class);
        List<MemberShape> labelMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpLabelTrait.class))
                .collect(Collectors.toList());
        System.out.println("\tURI BUILDER: " + operation.getId() + " has " + labelMembers.size() + " labels...");

        if (labelMembers.size() > 0) {
            String formatUri = httpTrait.getUri().toString()
                    .replaceAll("[{]([a-zA-Z0-9_]+)[}]", "%<$1>s"); //TODO: Handle greedy labels?
            String formatArgs = ""; // use string builder instead?
            System.out.println("\t\tURI: " + httpTrait.getUri() + " -> " + formatUri);

            for(MemberShape m : labelMembers) {
                HttpLabelTrait label = m.expectTrait(HttpLabelTrait.class);
                Shape target = model.expectShape(m.getTarget());
                System.out.println("\t\tAdding url subs for: " + target.getId());
                String symbolName =  RubyFormatter.asSymbol(m.getMemberName());
                formatArgs += ",\n" + m.getMemberName() + ": Seahorse::HTTP.uri_escape(params[" + symbolName + "].to_str)";
            }
            writer.openBlock("http_req.append_path(format(");
            writer.write("'$L'$L\n)", formatUri, formatArgs);
            writer.closeBlock(")");
        } else {
            writer.write("http_req.append_path('$L')", httpTrait.getUri());
        }
    }

    private void renderBuilderForStructure(RubyCodeWriter writer, StructureShape s) {
        System.out.println("\tRENDER builder for STRUCTURE: " + s.getId());
        generatedBuilders.add(s.toShapeId());

        writer
                .openBlock("\nclass $L", s.getId().getName())
                .call(() -> renderPermittedValues(writer, s))
                .openBlock("def self.build(params)")
                .write("params = Seahorse::Params.hash_value(params, permit: PERMIT)")
                .call(() -> renderMemberBuilders(writer, s))
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderPermittedValues(RubyCodeWriter writer, Shape shape) {
        String membersBlock = shape.members()
                .stream()
                .map(memberShape -> RubyFormatter.toSnakeCase(memberShape.getMemberName()))
                .collect(Collectors.joining(" "));

        writer
                .openBlock("PERMIT = Set.new(%i[")
                .write(membersBlock)
                .closeBlock("])");
    }

    private void renderBuilderForList(RubyCodeWriter writer, ListShape s) {
        System.out.println("\tRENDER parser for LIST: " + s.getId());
        generatedBuilders.add(s.toShapeId());

        // TODO
    }

    private void renderMemberBuilders(RubyCodeWriter writer, StructureShape s) {
        writer.write("data = {}");

        for(MemberShape member : s.members()) {
            Shape target = model.expectShape(member.getTarget());
            System.out.println("\t\tMEMBER BUILDER FOR: " + member.getId() + " target type: " + target.getType());

            String symbolName = RubyFormatter.asSymbol(member.getMemberName());
            // TODO: This may be where a vistor pattern is useful?
            if (target.isListShape() || target.isStructureShape()) {
                writer.write("data[$L] = Builders::$L.build(params[$L])", symbolName, target.getId().getName(), symbolName);
            } else {
                String convert = "";
                switch(target.getType()) {
                    case STRING:
                        convert = ".to_s";
                        break;
                    case INTEGER:
                        convert = ".to_i";
                        break;
                    case FLOAT:
                        convert = ".to_f";
                        break;
                }
                if (target.hasTrait(RequiredTrait.class))
                {
                    writer.write("data[$L] = params[$L]$L", symbolName, symbolName, convert);
                } else {
                    writer.write("data[$L] = params[$L]$L if params.key?($L)", symbolName, symbolName, convert, symbolName);
                }
            }
        }

        writer.write("return data");
    }
}
