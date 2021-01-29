package software.amazon.smithy.ruby.codegen.protocol.railsjson;

import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.RubyCodegenPlugin;
import software.amazon.smithy.ruby.codegen.generators.ClientGenerator;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.BuilderGenerator;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.ErrorsGenerator;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.ParserGenerator;

import java.util.logging.Logger;
import java.util.stream.Stream;

public class RailsJsonGenerator implements ProtocolGenerator {
    private static final Logger LOGGER = Logger.getLogger(RailsJsonGenerator.class.getName());

    @Override
    public ShapeId getProtocol() {
        return ShapeId.from("smithy.railsjson#RailsJson");
    }

    @Override
    public void generateBuilders(GenerationContext context) {
        BuilderGenerator builderGenerator = new BuilderGenerator(context.getRubySettings(), context.getModel());
        builderGenerator.render(context.getFileManifest());
        LOGGER.info("created builders");
    }

    @Override
    public void generateParsers(GenerationContext context) {
        ParserGenerator parserGenerator = new ParserGenerator(context.getRubySettings(), context.getModel());
        parserGenerator.render(context.getFileManifest());
        LOGGER.info("created parsers");
    }

    @Override
    public void generateErrors(GenerationContext context) {
        Stream<Shape> errorShapeStream = context.getModel().shapes().filter((s) -> s.hasTrait(ErrorTrait.class));
        ErrorsGenerator errorsGenerator = new ErrorsGenerator(context.getRubySettings(), errorShapeStream);
        errorsGenerator.render(context.getFileManifest());
        LOGGER.info("created errors");
    }

    @Override
    public void generateProtocolUnitTests(GenerationContext context) {
        LOGGER.info("Implement me!");
    }

    @Override
    public void generateProtocolClient(GenerationContext context) {
        Stream<OperationShape> operationShapeStream = context.getModel().shapes(OperationShape.class);
        ClientGenerator clientGenerator = new ClientGenerator(context.getRubySettings(), operationShapeStream);
        clientGenerator.render(context.getFileManifest());
        LOGGER.info("created client");
    }
}