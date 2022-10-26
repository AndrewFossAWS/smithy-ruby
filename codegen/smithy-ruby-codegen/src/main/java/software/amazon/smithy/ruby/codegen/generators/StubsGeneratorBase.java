/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

package software.amazon.smithy.ruby.codegen.generators;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;
import java.util.logging.Logger;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BigIntegerShape;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

/**
 * Base class for Stubs which iterates shapes and builds skeleton classes.
 *
 * <p>
 * Protocols should extend this class to get common functionality -
 * generates the framework and non-protocol specific parts of
 * stubs.rb.
 */
public abstract class StubsGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(RestStubsGeneratorBase.class.getName());

    protected final GenerationContext context;
    protected final RubySettings settings;
    protected final Model model;
    protected final Set<ShapeId> generatedStubs;
    protected final RubyCodeWriter writer;
    protected final SymbolProvider symbolProvider;


    public StubsGeneratorBase(GenerationContext context) {
        this.settings = context.settings();
        this.model = context.model();
        this.generatedStubs = new HashSet<>();
        this.context = context;
        this.writer = new RubyCodeWriter(context.settings().getModule() + "::Stubs");
        this.symbolProvider = context.symbolProvider();
    }

    /**
     * Called to render the stub method for Union shapes.
     * The class  skeleton is rendered outside of this method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * #### START code generated by this method
     * def self.stub(stub = {})
     *   stub ||= {}
     *   data = {}
     *   data[:string_value] = stub[:string_value] unless stub[:string_value].nil?
     *   data[:structure_value] = Stubs::GreetingStruct.stub(stub[:structure_value]) unless stub[:structure_value].nil?
     *   data
     * end
     * #### END code generated by this method
     * }</pre>
     *
     * @param shape shape to generate for
     */
    protected abstract void renderUnionStubMethod(UnionShape shape);

    /**
     * Called to render the stub method for list shapes.
     * The class  skeleton is rendered outside of this method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * #### START code generated by this method
     * def self.stub(stub = [])
     *   data = []
     *   stub.each do |element|
     *     data << element
     *   end
     *   data
     * end
     *  #### END code generated by this method
     * }</pre>
     *
     * @param shape shape to generate for
     */
    protected abstract void renderListStubMethod(ListShape shape);

    /**
     * Called to render the stub method for map shapes.
     * The class  skeleton is rendered outside of this method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * #### START code generated by this method
     * def self.stub(stub = {})
     *   data = {}
     *   stub.each do |key, value|
     *     data[key] = value
     *   end
     *   data
     * end
     * #### END code generated by this method
     * }</pre>
     *
     * @param shape shape to generate for
     */
    protected abstract void renderMapStubMethod(MapShape shape);

    /**
     * Called to render the stub method for Structure shapes.
     * The class skeleton is rendered outside of this method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * #### START code generated by this method
     * def self.stub(stub = {})
     *   stub ||= {}
     *   data = {}
     *   data[:value] = stub[:value] unless stub[:value].nil?
     *   data
     * end
     * #### END code generated by this method
     * }</pre>
     *
     * @param shape shape to generate for
     */
    protected abstract void renderStructureStubMethod(StructureShape shape);

    /**
     * Called to render the stub method for Operations.
     * The class skeleton is rendered outside of this method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * #### START code generated by this method
     * def self.stub(http_resp, stub:)
     *   data = {}
     *   http_resp.status = 200
     *   http_resp.headers['Content-Type'] = 'application/json'
     *   data['contents'] = Stubs::Contents.stub(stub[:contents]) unless stub[:contents].nil?
     *   http_resp.body = StringIO.new(Hearth::JSON.dump(data))
     * end
     * #### END code generated by this method
     * }</pre>
     *
     * @param operation   operation to render stub method for
     * @param outputShape output shape of the operation
     */
    protected abstract void renderOperationStubMethod(OperationShape operation, Shape outputShape);


    public void render(FileManifest fileManifest) {

        writer
                .includePreamble()
                .includeRequires()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Stubs")
                .call(() -> renderStubs())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/stubs.rb";
        fileManifest.writeFile(fileName, writer.toString());

        LOGGER.fine("Wrote stubs to " + fileName);
    }

    private void renderStubs() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.service()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> {
                    Shape outputShape = model.expectShape(o.getOutputShape());
                    renderStubsForOperation(o, outputShape);
                    generatedStubs.add(o.toShapeId());

                    Iterator<Shape> it = new Walker(model).iterateShapes(outputShape);
                    while (it.hasNext()) {
                        Shape s = it.next();
                        if (!generatedStubs.contains(s.getId())) {
                            generatedStubs.add(s.getId());
                            s.accept(new StubClassGenerator());
                        }
                    }
                });
    }

    // The Output shape is combined with the OperationStub
    // This generates the setting of the body (if any non-http input) as if it was the Stubber for the Output
    private void renderStubsForOperation(OperationShape operation, Shape outputShape) {
        generatedStubs.add(outputShape.getId());

        writer
                .write("")
                .write("# Operation Stubber for $L", operation.getId().getName())
                .openBlock("class $L", symbolProvider.toSymbol(operation).getName())
                .openBlock("def self.default(visited=[])")
                .call(() -> renderMemberDefaults(outputShape))
                .closeBlock("end")
                .write("")
                .call(() -> renderOperationStubMethod(operation, outputShape))
                .closeBlock("end");
        LOGGER.finer("Generated stubber for operation " + operation.getId().getName());
    }

    protected void renderMemberDefaults(Shape s) {
        writer.openBlock("{");
        s.members().forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());

            String symbolName = symbolProvider.toMemberName(member);
            String dataSetter = symbolName + ": ";
            target.accept(new MemberDefaults(dataSetter, ",", symbolName));
        });
        writer.closeBlock("}");
    }

    protected void renderStreamingStub(Shape inputShape) {
        MemberShape streamingMember = inputShape.members().stream()
                .filter((m) -> m.getMemberTrait(model, StreamingTrait.class).isPresent())
                .findFirst().get();

        writer.write("IO.copy_stream(stub[:$L], http_resp.body)",
                symbolProvider.toMemberName(streamingMember));
    }

    private class StubClassGenerator extends ShapeVisitor.Default<Void> {

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer
                    .write("")
                    .write("# Structure Stubber for $L", shape.getId().getName())
                    .openBlock("class $L", name)
                    .openBlock("def self.default(visited=[])")
                    .write("return nil if visited.include?('$L')", name)
                    .write("visited = visited + ['$L']", name)
                    .call(() -> renderMemberDefaults(shape))
                    .closeBlock("end")
                    .write("")
                    .call(() -> renderStructureStubMethod(shape))
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            Shape memberTarget =
                    model.expectShape(shape.getMember().getTarget());
            writer
                    .write("")
                    .write("# List Stubber for $L", shape.getId().getName())
                    .openBlock("class $L", name)
                    .openBlock("def self.default(visited=[])")
                    .write("return nil if visited.include?('$L')", name)
                    .write("visited = visited + ['$L']", name)
                    .openBlock("[")
                    .call(() -> memberTarget.accept(new MemberDefaults("", "",
                            symbolProvider.toMemberName(shape.getMember()))))
                    .closeBlock("]")
                    .closeBlock("end")
                    .write("")
                    .call(() -> renderListStubMethod(shape))
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            Shape valueTarget = model.expectShape(shape.getValue().getTarget());

            writer
                    .write("")
                    .write("# Map Stubber for $L", shape.getId().getName())
                    .openBlock("class $L", name)
                    .openBlock("def self.default(visited=[])")
                    .write("return nil if visited.include?('$L')", name)
                    .write("visited = visited + ['$L']", name)
                    .openBlock("{")
                    .call(() -> valueTarget
                            .accept(new MemberDefaults("test_key: ", "",
                                    symbolProvider.toMemberName(shape.getValue()))))
                    .closeBlock("}")
                    .closeBlock("end")
                    .write("")
                    .call(() -> renderMapStubMethod(shape))
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer
                    .write("")
                    .write("# Union Stubber for $L", shape.getId().getName())
                    .openBlock("class $L", name)
                    .openBlock("def self.default(visited=[])")
                    .write("return nil if visited.include?('$L')", name)
                    .write("visited = visited + ['$L']", name)
                    .call(() -> {
                        writer.openBlock("{");
                        MemberShape defaultMember = shape.members().iterator().next();
                        Shape target = model.expectShape(defaultMember.getTarget());
                        String symbolName = RubyFormatter.toSnakeCase(symbolProvider.toMemberName(defaultMember));
                        String dataSetter = symbolName + ": ";
                        target.accept(new MemberDefaults(dataSetter, ",", symbolName));
                        writer.closeBlock("}");
                    })
                    .closeBlock("end")
                    .write("")
                    .call(() -> renderUnionStubMethod(shape))
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void documentShape(DocumentShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer
                    .write("")
                    .write("# Document Type Stubber for $L", name)
                    .openBlock("class $L", name)
                    .openBlock("def self.default(visited=[])")
                    .write("return nil if visited.include?('$L')", name)
                    .write("visited = visited + ['$L']", name)
                    .write("{ '$L' => [0, 1, 2] }", name)
                    .closeBlock("end")
                    .write("")
                    .openBlock("def self.stub(stub = {})")
                    .write("stub")
                    .closeBlock("end")
                    .closeBlock("end");

            return null;
        }
    }

    private class MemberDefaults extends ShapeVisitor.Default<Void> {

        private final String eol;
        private final String dataSetter;
        private final String memberName;

        MemberDefaults(String dataSetter, String eol,
                       String memberName) {
            this.eol = eol;
            this.dataSetter = dataSetter;
            this.memberName = memberName;
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$Lnil$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void blobShape(BlobShape blob) {
            writer.write("$L'$L'$L", dataSetter, memberName, eol);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write("$L1.0$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            writer.write("$L1.0$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void bigIntegerShape(BigIntegerShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void bigDecimalShape(BigDecimalShape shape) {
            writer.write("$L1.0$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("$L'$L'$L", dataSetter, memberName, eol);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("$LTime.now$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write("$Lfalse$L", dataSetter, eol);
            return null;
        }

        /**
         * For complex shapes, simply delegate to their Stubber.
         */
        private void complexShapeDefaults(Shape shape) {
            writer.write("$L$L.default(visited)$L", dataSetter, symbolProvider.toSymbol(shape).getName(), eol);
        }

        @Override
        public Void listShape(ListShape shape) {
            complexShapeDefaults(shape);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            complexShapeDefaults(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            complexShapeDefaults(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            complexShapeDefaults(shape);
            return null;
        }
    }
}
