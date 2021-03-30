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
package software.amazon.smithy.ruby.codegen;

import java.util.*;

import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;


/**
 * Represents the resolves {@link Symbol}s and references for an
 * application Transport (aka Application Protocol) (e.g., "http", "mqtt", etc).
 */
public final class ApplicationTransport {

    private final String name;
    private final ClientFragment request;
    private final ClientFragment response;
    private final ClientFragment transportClient;
    private final MiddlewareList defaultMiddleware;

    /**
     * Creates a resolved application transport.
     */
    public ApplicationTransport(
            String name,
            ClientFragment request,
            ClientFragment response,
            ClientFragment transportClient,
            MiddlewareList defaultMiddleware

    ) {
        //TODO: Create a builder for this
        this.name = name;
        this.request = request;
        this.response = response;
        this.transportClient = transportClient;
        this.defaultMiddleware = defaultMiddleware;
    }

    @FunctionalInterface
    public interface MiddlewareList {
        /**
         * Called to Render the addition of this middleware to the stack
         */
        List<Middleware> list(ApplicationTransport transport, GenerationContext context);
    }

    /**
     * Creates a default HTTP application transport.
     *
     * @return Returns the created application Transport.
     */
    public static ApplicationTransport createDefaultHttpApplicationTransport() {
        ClientConfig endpoint = (new ClientConfig.Builder())
                .name("endpoint")
                .type("string")
                .documentation("Endpoint of the service")
                .build();

        ClientFragment request = (new ClientFragment.Builder())
                .addConfig(endpoint)
                .render( (self, ctx) -> "Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint))")
                .build();

        ClientFragment response = (new ClientFragment.Builder())
                .render( (self, ctx) -> "Seahorse::HTTP::Response.new(body: output_stream)")
                .build();

        ClientConfig wireTrace = (new ClientConfig.Builder())
                .name("http_wire_trace")
                .type("bool")
                .defaultValue("false")
                .documentation("Enable debug wire trace on http requests.")
                .build();

        ClientConfig logger = (new ClientConfig.Builder())
                .name("logger")
                .type("Logger")
                .defaultValue("stdout")
                .initializationCustomization("@logger = options.fetch(:logger, Logger.new($stdout, level: @log_level))")
                .documentation("Logger to use for output")
                .build();

        ClientConfig logLevel = (new ClientConfig.Builder())
                .name("log_level")
                .type("symbol")
                .defaultValue(":info")
                .documentation("Default log level to use")
                .build();

        ClientFragment client = (new ClientFragment.Builder())
                .addConfig(wireTrace)
                .addConfig(logger)
                .addConfig(logLevel)
                .render( (self, ctx) -> "Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace)")
                .build();

        MiddlewareList defaultMiddleware = (transport, context) -> {
            List<Middleware> middleware = new ArrayList();
            middleware.add((new Middleware.Builder())
                    .klass("Seahorse::HTTP::Middleware::ContentLength")
                    .step(MiddlewareStackStep.BUILD)
                    .build()
            );

            middleware.add((new Middleware.Builder())
                    .klass("Seahorse::Middleware::Parse")
                    .step(MiddlewareStackStep.DESERIALIZE)
                    .operationParams( (ctx, operation) -> {
                        Map<String, String> params = new HashMap<>();
                        params.put("data_parser", "Parsers::" + operation.getId().getName());
                        //TODO: Extract these from the operation, http trait.
                        String successCode = "200";
                        String errors = "[]";
                        params.put("error_parser", "Seahorse::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status_code: " + successCode + ", errors: " + errors + ")");
                        return params;
                    })
                    .build()
            );

            return middleware;
        };

        return new ApplicationTransport(
                "http",
                request,
                response,
                client,
                defaultMiddleware);
    }

    /**
     * Gets the Transport name.
     *
     * <p>All HTTP Transports should start with "http".
     * All MQTT Transports should start with "mqtt".
     *
     * @return Returns the Transport name.
     */
    public String getName() {
        return name;
    }

    /**
     * Checks if the Transport is an HTTP based Transport.
     *
     * @return Returns true if it is HTTP based.
     */
    public boolean isHttpTransport() {
        return getName().startsWith("http");
    }

    public ClientFragment getRequest() {
        return request;
    }

    public ClientFragment getResponse() {
        return response;
    }

    public ClientFragment getTransportClient() {
        return transportClient;
    }

    public List<Middleware> defaultMiddleware(GenerationContext context) {
        return this.defaultMiddleware.list(this, context);
    }

    public Set<ClientConfig> getClientConfig() {
        Set<ClientConfig> config = new HashSet();
        config.addAll(request.getClientConfig());
        config.addAll(response.getClientConfig());
        config.addAll(transportClient.getClientConfig());
        return config;
    }

    @Override
    public String toString() {
        return "ApplicationTransport<" + getName() + ">";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (!(o instanceof ApplicationTransport)) {
            return false;
        }

        ApplicationTransport that = (ApplicationTransport) o;
        return name.equals(that.name);
    }
}