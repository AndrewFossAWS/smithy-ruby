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

package software.amazon.smithy.ruby.codegen;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Interface that all ProtocolGenerators must implement.
 * <p>
 * Each generate method will be called by the CodegenOrchestrator
 * and should generate and write out the appropriate file.
 */
@SmithyUnstableApi
public interface ProtocolGenerator {

    /**
     * @return The ShapeId of the protocol that this generator applies to.
     * This is used to match loaded ProtocolGenerators to the
     * services protocols.
     */
    ShapeId getProtocol();

    /**
     * @return The ApplicationTransport that should be used for this protocol.
     */
    ApplicationTransport getApplicationTransport();

    /**
     * Called to generate builders (data serializers).
     * Builders must be written to builders.rb and
     * each operation must have a class that implements the
     * `build(req, input:)` method.
     *
     * @param context context to use for generation
     */
    void generateBuilders(GenerationContext context);

    /**
     * Called to generate parsers (data deserializers).
     * Parsers must be written to parsers.rb and
     * each operation must have a class that implements the
     * `parse(resp)` method.
     *
     * @param context context to use for generation
     */
    void generateParsers(GenerationContext context);

    /**
     * Called to generate errors.
     * Errors must be written to errors.rb and
     * should define a class for each modeled error
     * as well as classes for ApiError, ApiServiceError,
     * and ApiClientError.
     *
     * @param context context to use for generation
     */
    void generateErrors(GenerationContext context);

    /**
     * Called to generate stubs.
     * Stubs must be written to stubs.rb and
     * should define a class for each operation
     * that implements the `default` and `stub(resp, stub:)` method.
     *
     * @param context context to use for generation
     */
    void generateStubs(GenerationContext context);

    /**
     * Return all of the Middleware to be registered on the Client.
     *
     * @param middlewareBuilder - Client middleware to be modified
     * @param context           - Generation context to process within
     */
    default void modifyClientMiddleware(MiddlewareBuilder middlewareBuilder, GenerationContext context) {
        // pass
    }

    /**
     * Returns a list of additional (non-middleware) Config
     * to be added to the generated Client.
     *
     * @param context - Generation context to process within
     * @return list of additional config
     */
    default List<ClientConfig> getAdditionalClientConfig(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Writes additional files.
     *
     * @param context - context for generation
     * @return List of relative paths generated to be added to module requires.
     */
    default List<String> writeAdditionalFiles(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Adds additional Gem Dependencies.
     *
     * @param rubySettings       - generation settings
     * @param finalResolvedModel - the resolved model (post any transforms)
     * @param service            - service to generate for
     * @param protocol           - the resolved protocol
     * @return Set of ruby dependencies to be added
     */
    default Set<RubyDependency> additionalGemDependencies(
            RubySettings rubySettings, Model finalResolvedModel,
            ServiceShape service, ShapeId protocol) {
        return Collections.emptySet();
    }

    static Map<ShapeId, ProtocolGenerator> collectSupportedProtocolGenerators(
        List<RubyIntegration> integrations
    ) {
        Map<ShapeId, ProtocolGenerator> generators = new HashMap<>();
        for (RubyIntegration integration : integrations) {
            for (ProtocolGenerator generator : integration.getProtocolGenerators()) {
                generators.put(generator.getProtocol(), generator);
            }
        }
        return generators;
    }

    static Optional<ProtocolGenerator> resolve(
        ShapeId protocol,
        List<RubyIntegration> integrations
    ) {
        for (RubyIntegration integration : integrations) {
            Optional<ProtocolGenerator> pg = integration.getProtocolGenerators()
                    .stream().filter((p) -> p.getProtocol().equals(protocol))
                    .findFirst();
            if (pg.isPresent()) {
                return pg;
            }
        }
        return Optional.empty();
    }
}
