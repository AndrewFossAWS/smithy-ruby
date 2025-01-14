# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

require_relative 'middleware/request_id'

module RailsJson
  # An API client for RailsJson
  # See {#initialize} for a full list of supported configuration options

  class Client
    include Hearth::ClientStubs

    @middleware = Hearth::MiddlewareBuilder.new

    def self.middleware
      @middleware
    end

    # @param [Config] config
    #   An instance of {Config}
    #
    def initialize(config = RailsJson::Config.new, options = {})
      @config = config
      @middleware = Hearth::MiddlewareBuilder.new(options[:middleware])
      @stubs = Hearth::Stubbing::Stubs.new
      @retry_quota = Hearth::Retry::RetryQuota.new
      @client_rate_limiter = Hearth::Retry::ClientRateLimiter.new
    end

    # This example uses all query string types.
    #
    # @param [Hash] params
    #   See {Types::AllQueryStringTypesInput}.
    #
    # @return [Types::AllQueryStringTypesOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.all_query_string_types(
    #     query_string: 'queryString',
    #     query_string_list: [
    #       'member'
    #     ],
    #     query_string_set: [
    #       'member'
    #     ],
    #     query_byte: 1,
    #     query_short: 1,
    #     query_integer: 1,
    #     query_integer_list: [
    #       1
    #     ],
    #     query_integer_set: [
    #       1
    #     ],
    #     query_long: 1,
    #     query_float: 1.0,
    #     query_double: 1.0,
    #     query_double_list: [
    #       1.0
    #     ],
    #     query_boolean: false,
    #     query_boolean_list: [
    #       false
    #     ],
    #     query_timestamp: Time.now,
    #     query_timestamp_list: [
    #       Time.now
    #     ],
    #     query_enum: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     query_enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     query_params_map_of_strings: {
    #       'key' => 'value'
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::AllQueryStringTypesOutput
    #
    def all_query_string_types(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::AllQueryStringTypesInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::AllQueryStringTypesInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::AllQueryStringTypes
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::AllQueryStringTypes
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::AllQueryStringTypes,
        stubs: @stubs,
        params_class: Params::AllQueryStringTypesOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :all_query_string_types
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example uses fixed query string params and variable query string params.
    # The fixed query string parameters and variable parameters must both be
    # serialized (implementations may need to merge them together).
    #
    # @param [Hash] params
    #   See {Types::ConstantAndVariableQueryStringInput}.
    #
    # @return [Types::ConstantAndVariableQueryStringOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.constant_and_variable_query_string(
    #     baz: 'baz',
    #     maybe_set: 'maybeSet'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::ConstantAndVariableQueryStringOutput
    #
    def constant_and_variable_query_string(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::ConstantAndVariableQueryStringInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ConstantAndVariableQueryStringInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ConstantAndVariableQueryString
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::ConstantAndVariableQueryString
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::ConstantAndVariableQueryString,
        stubs: @stubs,
        params_class: Params::ConstantAndVariableQueryStringOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :constant_and_variable_query_string
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example uses a constant query string parameters and a label.
    # This simply tests that labels and query string parameters are
    # compatible. The fixed query string parameter named "hello" should
    # in no way conflict with the label, `{hello}`.
    #
    # @param [Hash] params
    #   See {Types::ConstantQueryStringInput}.
    #
    # @return [Types::ConstantQueryStringOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.constant_query_string(
    #     hello: 'hello' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::ConstantQueryStringOutput
    #
    def constant_query_string(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::ConstantQueryStringInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ConstantQueryStringInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ConstantQueryString
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::ConstantQueryString
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::ConstantQueryString,
        stubs: @stubs,
        params_class: Params::ConstantQueryStringOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :constant_query_string
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example serializes a document as part of the payload.
    #
    # @param [Hash] params
    #   See {Types::DocumentTypeInput}.
    #
    # @return [Types::DocumentTypeOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.document_type(
    #     string_value: 'stringValue',
    #     document_value: {
    #       'nil' => nil,
    #       'number' => 123.0,
    #       'string' => 'value',
    #       'boolean' => true,
    #       'array' => [],
    #       'map' => {}
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::DocumentTypeOutput
    #   resp.data.string_value #=> String
    #   resp.data.document_value #=> Hash,Array,String,Boolean,Numeric
    #
    def document_type(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::DocumentTypeInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::DocumentTypeInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::DocumentType
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::DocumentType
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::DocumentType,
        stubs: @stubs,
        params_class: Params::DocumentTypeOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :document_type
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example serializes a document as the entire HTTP payload.
    #
    # @param [Hash] params
    #   See {Types::DocumentTypeAsPayloadInput}.
    #
    # @return [Types::DocumentTypeAsPayloadOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.document_type_as_payload(
    #     document_value: {
    #       'nil' => nil,
    #       'number' => 123.0,
    #       'string' => 'value',
    #       'boolean' => true,
    #       'array' => [],
    #       'map' => {}
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::DocumentTypeAsPayloadOutput
    #   resp.data.document_value #=> Hash,Array,String,Boolean,Numeric
    #
    def document_type_as_payload(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::DocumentTypeAsPayloadInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::DocumentTypeAsPayloadInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::DocumentTypeAsPayload
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::DocumentTypeAsPayload
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::DocumentTypeAsPayload,
        stubs: @stubs,
        params_class: Params::DocumentTypeAsPayloadOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :document_type_as_payload
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::EmptyOperationInput}.
    #
    # @return [Types::EmptyOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.empty_operation()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::EmptyOperationOutput
    #
    def empty_operation(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::EmptyOperationInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::EmptyOperationInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::EmptyOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::EmptyOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::EmptyOperation,
        stubs: @stubs,
        params_class: Params::EmptyOperationOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :empty_operation
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::EndpointOperationInput}.
    #
    # @return [Types::EndpointOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.endpoint_operation()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::EndpointOperationOutput
    #
    def endpoint_operation(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::EndpointOperationInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::EndpointOperationInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::HostPrefix,
        host_prefix: "foo.",
        disable_host_prefix: @config.disable_host_prefix
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::EndpointOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::EndpointOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::EndpointOperation,
        stubs: @stubs,
        params_class: Params::EndpointOperationOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :endpoint_operation
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::EndpointWithHostLabelOperationInput}.
    #
    # @return [Types::EndpointWithHostLabelOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.endpoint_with_host_label_operation(
    #     label_member: 'labelMember' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::EndpointWithHostLabelOperationOutput
    #
    def endpoint_with_host_label_operation(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::EndpointWithHostLabelOperationInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::EndpointWithHostLabelOperationInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::HostPrefix,
        host_prefix: "foo.{label_member}.",
        disable_host_prefix: @config.disable_host_prefix
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::EndpointWithHostLabelOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::EndpointWithHostLabelOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::EndpointWithHostLabelOperation,
        stubs: @stubs,
        params_class: Params::EndpointWithHostLabelOperationOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :endpoint_with_host_label_operation
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This operation has three possible return values:
    #
    # 1. A successful response in the form of GreetingWithErrorsOutput
    # 2. An InvalidGreeting error.
    # 3. A ComplexError error.
    #
    # Implementations must be able to successfully take a response and
    # properly deserialize successful and error responses.
    #
    # @param [Hash] params
    #   See {Types::GreetingWithErrorsInput}.
    #
    # @return [Types::GreetingWithErrorsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.greeting_with_errors()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::GreetingWithErrorsOutput
    #   resp.data.greeting #=> String
    #
    def greeting_with_errors(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::GreetingWithErrorsInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GreetingWithErrorsInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GreetingWithErrors
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: [Errors::InvalidGreeting, Errors::ComplexError]),
        data_parser: Parsers::GreetingWithErrors
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::GreetingWithErrors,
        stubs: @stubs,
        params_class: Params::GreetingWithErrorsOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :greeting_with_errors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples serializes a blob shape in the payload.
    #
    # In this example, no JSON document is synthesized because the payload is
    # not a structure or a union type.
    #
    # @param [Hash] params
    #   See {Types::HttpPayloadTraitsInput}.
    #
    # @return [Types::HttpPayloadTraitsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_payload_traits(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpPayloadTraitsOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> String
    #
    def http_payload_traits(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPayloadTraitsInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPayloadTraitsInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPayloadTraits
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpPayloadTraits
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpPayloadTraits,
        stubs: @stubs,
        params_class: Params::HttpPayloadTraitsOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_payload_traits
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples uses a `@mediaType` trait on the payload to force a custom
    # content-type to be serialized.
    #
    # @param [Hash] params
    #   See {Types::HttpPayloadTraitsWithMediaTypeInput}.
    #
    # @return [Types::HttpPayloadTraitsWithMediaTypeOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_payload_traits_with_media_type(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpPayloadTraitsWithMediaTypeOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> String
    #
    def http_payload_traits_with_media_type(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPayloadTraitsWithMediaTypeInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPayloadTraitsWithMediaTypeInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPayloadTraitsWithMediaType
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpPayloadTraitsWithMediaType
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpPayloadTraitsWithMediaType,
        stubs: @stubs,
        params_class: Params::HttpPayloadTraitsWithMediaTypeOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_payload_traits_with_media_type
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples serializes a structure in the payload.
    #
    # Note that serializing a structure changes the wrapper element name
    # to match the targeted structure.
    #
    # @param [Hash] params
    #   See {Types::HttpPayloadWithStructureInput}.
    #
    # @return [Types::HttpPayloadWithStructureOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_payload_with_structure(
    #     nested: {
    #       greeting: 'greeting',
    #       name: 'name'
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpPayloadWithStructureOutput
    #   resp.data.nested #=> Types::NestedPayload
    #   resp.data.nested.greeting #=> String
    #   resp.data.nested.name #=> String
    #
    def http_payload_with_structure(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPayloadWithStructureInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPayloadWithStructureInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPayloadWithStructure
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpPayloadWithStructure
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpPayloadWithStructure,
        stubs: @stubs,
        params_class: Params::HttpPayloadWithStructureOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_payload_with_structure
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples adds headers to the input of a request and response by prefix.
    #
    # @see https://awslabs.github.io/smithy/1.0/spec/http.html#httpprefixheaders-trait httpPrefixHeaders Trait
    #
    # @param [Hash] params
    #   See {Types::HttpPrefixHeadersInput}.
    #
    # @return [Types::HttpPrefixHeadersOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_prefix_headers(
    #     foo: 'foo',
    #     foo_map: {
    #       'key' => 'value'
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpPrefixHeadersOutput
    #   resp.data.foo #=> String
    #   resp.data.foo_map #=> Hash<String, String>
    #   resp.data.foo_map['key'] #=> String
    #
    def http_prefix_headers(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPrefixHeadersInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPrefixHeadersInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPrefixHeaders
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpPrefixHeaders
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpPrefixHeaders,
        stubs: @stubs,
        params_class: Params::HttpPrefixHeadersOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_prefix_headers
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Clients that perform this test extract all headers from the response.
    #
    # @param [Hash] params
    #   See {Types::HttpPrefixHeadersInResponseInput}.
    #
    # @return [Types::HttpPrefixHeadersInResponseOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_prefix_headers_in_response()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpPrefixHeadersInResponseOutput
    #   resp.data.prefix_headers #=> Hash<String, String>
    #   resp.data.prefix_headers['key'] #=> String
    #
    def http_prefix_headers_in_response(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPrefixHeadersInResponseInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPrefixHeadersInResponseInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPrefixHeadersInResponse
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpPrefixHeadersInResponse
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpPrefixHeadersInResponse,
        stubs: @stubs,
        params_class: Params::HttpPrefixHeadersInResponseOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_prefix_headers_in_response
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::HttpRequestWithFloatLabelsInput}.
    #
    # @return [Types::HttpRequestWithFloatLabelsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_request_with_float_labels(
    #     float: 1.0, # required
    #     double: 1.0 # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpRequestWithFloatLabelsOutput
    #
    def http_request_with_float_labels(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithFloatLabelsInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithFloatLabelsInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithFloatLabels
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpRequestWithFloatLabels
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpRequestWithFloatLabels,
        stubs: @stubs,
        params_class: Params::HttpRequestWithFloatLabelsOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_request_with_float_labels
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::HttpRequestWithGreedyLabelInPathInput}.
    #
    # @return [Types::HttpRequestWithGreedyLabelInPathOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_request_with_greedy_label_in_path(
    #     foo: 'foo', # required
    #     baz: 'baz' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpRequestWithGreedyLabelInPathOutput
    #
    def http_request_with_greedy_label_in_path(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithGreedyLabelInPathInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithGreedyLabelInPathInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithGreedyLabelInPath
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpRequestWithGreedyLabelInPath
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpRequestWithGreedyLabelInPath,
        stubs: @stubs,
        params_class: Params::HttpRequestWithGreedyLabelInPathOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_request_with_greedy_label_in_path
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests how requests are serialized when there's no input
    # payload but there are HTTP labels.
    #
    # @param [Hash] params
    #   See {Types::HttpRequestWithLabelsInput}.
    #
    # @option params [Boolean] :boolean
    #   Serialized in the path as true or false.
    #
    # @option params [Time] :timestamp
    #   Note that this member has no format, so it's serialized as an RFC 3399 date-time.
    #
    # @return [Types::HttpRequestWithLabelsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_request_with_labels(
    #     string: 'string', # required
    #     short: 1, # required
    #     integer: 1, # required
    #     long: 1, # required
    #     float: 1.0, # required
    #     double: 1.0, # required
    #     boolean: false, # required
    #     timestamp: Time.now # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpRequestWithLabelsOutput
    #
    def http_request_with_labels(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithLabelsInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithLabelsInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithLabels
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpRequestWithLabels
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpRequestWithLabels,
        stubs: @stubs,
        params_class: Params::HttpRequestWithLabelsOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_request_with_labels
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests how requests serialize different timestamp formats in the
    # URI path.
    #
    # @param [Hash] params
    #   See {Types::HttpRequestWithLabelsAndTimestampFormatInput}.
    #
    # @return [Types::HttpRequestWithLabelsAndTimestampFormatOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_request_with_labels_and_timestamp_format(
    #     member_epoch_seconds: Time.now, # required
    #     member_http_date: Time.now, # required
    #     member_date_time: Time.now, # required
    #     default_format: Time.now, # required
    #     target_epoch_seconds: Time.now, # required
    #     target_http_date: Time.now, # required
    #     target_date_time: Time.now # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpRequestWithLabelsAndTimestampFormatOutput
    #
    def http_request_with_labels_and_timestamp_format(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithLabelsAndTimestampFormatInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithLabelsAndTimestampFormatInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithLabelsAndTimestampFormat
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpRequestWithLabelsAndTimestampFormat
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpRequestWithLabelsAndTimestampFormat,
        stubs: @stubs,
        params_class: Params::HttpRequestWithLabelsAndTimestampFormatOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_request_with_labels_and_timestamp_format
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::HttpResponseCodeInput}.
    #
    # @return [Types::HttpResponseCodeOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.http_response_code()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::HttpResponseCodeOutput
    #   resp.data.status #=> Integer
    #
    def http_response_code(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpResponseCodeInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpResponseCodeInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpResponseCode
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::HttpResponseCode
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::HttpResponseCode,
        stubs: @stubs,
        params_class: Params::HttpResponseCodeOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :http_response_code
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example ensures that query string bound request parameters are
    # serialized in the body of responses if the structure is used in both
    # the request and response.
    #
    # @param [Hash] params
    #   See {Types::IgnoreQueryParamsInResponseInput}.
    #
    # @return [Types::IgnoreQueryParamsInResponseOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.ignore_query_params_in_response()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::IgnoreQueryParamsInResponseOutput
    #   resp.data.baz #=> String
    #
    def ignore_query_params_in_response(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::IgnoreQueryParamsInResponseInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::IgnoreQueryParamsInResponseInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::IgnoreQueryParamsInResponse
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::IgnoreQueryParamsInResponse
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::IgnoreQueryParamsInResponse,
        stubs: @stubs,
        params_class: Params::IgnoreQueryParamsInResponseOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :ignore_query_params_in_response
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests how requests and responses are serialized when there is
    # no input or output payload but there are HTTP header bindings.
    #
    # @param [Hash] params
    #   See {Types::InputAndOutputWithHeadersInput}.
    #
    # @return [Types::InputAndOutputWithHeadersOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.input_and_output_with_headers(
    #     header_string: 'headerString',
    #     header_byte: 1,
    #     header_short: 1,
    #     header_integer: 1,
    #     header_long: 1,
    #     header_float: 1.0,
    #     header_double: 1.0,
    #     header_true_bool: false,
    #     header_false_bool: false,
    #     header_string_list: [
    #       'member'
    #     ],
    #     header_string_set: [
    #       'member'
    #     ],
    #     header_integer_list: [
    #       1
    #     ],
    #     header_boolean_list: [
    #       false
    #     ],
    #     header_timestamp_list: [
    #       Time.now
    #     ],
    #     header_enum: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     header_enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ]
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::InputAndOutputWithHeadersOutput
    #   resp.data.header_string #=> String
    #   resp.data.header_byte #=> Integer
    #   resp.data.header_short #=> Integer
    #   resp.data.header_integer #=> Integer
    #   resp.data.header_long #=> Integer
    #   resp.data.header_float #=> Float
    #   resp.data.header_double #=> Float
    #   resp.data.header_true_bool #=> Boolean
    #   resp.data.header_false_bool #=> Boolean
    #   resp.data.header_string_list #=> Array<String>
    #   resp.data.header_string_list[0] #=> String
    #   resp.data.header_string_set #=> Array<String>
    #   resp.data.header_string_set[0] #=> String
    #   resp.data.header_integer_list #=> Array<Integer>
    #   resp.data.header_integer_list[0] #=> Integer
    #   resp.data.header_boolean_list #=> Array<Boolean>
    #   resp.data.header_boolean_list[0] #=> Boolean
    #   resp.data.header_timestamp_list #=> Array<Time>
    #   resp.data.header_timestamp_list[0] #=> Time
    #   resp.data.header_enum #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.header_enum_list #=> Array<String>
    #   resp.data.header_enum_list[0] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #
    def input_and_output_with_headers(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::InputAndOutputWithHeadersInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::InputAndOutputWithHeadersInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::InputAndOutputWithHeaders
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::InputAndOutputWithHeaders
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::InputAndOutputWithHeaders,
        stubs: @stubs,
        params_class: Params::InputAndOutputWithHeadersOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :input_and_output_with_headers
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example serializes enums as top level properties, in lists, sets, and maps.
    #
    # @param [Hash] params
    #   See {Types::JsonEnumsInput}.
    #
    # @return [Types::JsonEnumsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.json_enums(
    #     foo_enum1: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     foo_enum2: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     foo_enum3: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     foo_enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     foo_enum_set: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     foo_enum_map: {
    #       'key' => 'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::JsonEnumsOutput
    #   resp.data.foo_enum1 #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum2 #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum3 #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum_list #=> Array<String>
    #   resp.data.foo_enum_list[0] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum_set #=> Array<String>
    #   resp.data.foo_enum_set[0] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum_map #=> Hash<String, String>
    #   resp.data.foo_enum_map['key'] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #
    def json_enums(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::JsonEnumsInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::JsonEnumsInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::JsonEnums
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::JsonEnums
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::JsonEnums,
        stubs: @stubs,
        params_class: Params::JsonEnumsOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :json_enums
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests basic map serialization.
    #
    # @param [Hash] params
    #   See {Types::JsonMapsInput}.
    #
    # @return [Types::JsonMapsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.json_maps(
    #     dense_struct_map: {
    #       'key' => {
    #         hi: 'hi'
    #       }
    #     },
    #     dense_number_map: {
    #       'key' => 1
    #     },
    #     dense_boolean_map: {
    #       'key' => false
    #     },
    #     dense_string_map: {
    #       'key' => 'value'
    #     },
    #     sparse_number_map: {
    #       'key' => 1
    #     },
    #     sparse_boolean_map: {
    #       'key' => false
    #     },
    #     sparse_string_map: {
    #       'key' => 'value'
    #     },
    #     dense_set_map: {
    #       'key' => [
    #         'member'
    #       ]
    #     },
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::JsonMapsOutput
    #   resp.data.dense_struct_map #=> Hash<String, GreetingStruct>
    #   resp.data.dense_struct_map['key'] #=> Types::GreetingStruct
    #   resp.data.dense_struct_map['key'].hi #=> String
    #   resp.data.sparse_struct_map #=> Hash<String, GreetingStruct>
    #   resp.data.dense_number_map #=> Hash<String, Integer>
    #   resp.data.dense_number_map['key'] #=> Integer
    #   resp.data.dense_boolean_map #=> Hash<String, Boolean>
    #   resp.data.dense_boolean_map['key'] #=> Boolean
    #   resp.data.dense_string_map #=> Hash<String, String>
    #   resp.data.dense_string_map['key'] #=> String
    #   resp.data.sparse_number_map #=> Hash<String, Integer>
    #   resp.data.sparse_number_map['key'] #=> Integer
    #   resp.data.sparse_boolean_map #=> Hash<String, Boolean>
    #   resp.data.sparse_boolean_map['key'] #=> Boolean
    #   resp.data.sparse_string_map #=> Hash<String, String>
    #   resp.data.sparse_string_map['key'] #=> String
    #   resp.data.dense_set_map #=> Hash<String, Array<String>>
    #   resp.data.dense_set_map['key'] #=> Array<String>
    #   resp.data.dense_set_map['key'][0] #=> String
    #   resp.data.sparse_set_map #=> Hash<String, Array<String>>
    #
    def json_maps(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::JsonMapsInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::JsonMapsInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::JsonMaps
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::JsonMaps
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::JsonMaps,
        stubs: @stubs,
        params_class: Params::JsonMapsOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :json_maps
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This operation uses unions for inputs and outputs.
    #
    # @param [Hash] params
    #   See {Types::JsonUnionsInput}.
    #
    # @option params [MyUnion] :contents
    #   A union with a representative set of types for members.
    #
    # @return [Types::JsonUnionsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.json_unions(
    #     contents: {
    #       # One of:
    #       string_value: 'stringValue',
    #       boolean_value: false,
    #       number_value: 1,
    #       blob_value: 'blobValue',
    #       timestamp_value: Time.now,
    #       enum_value: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #       list_value: [
    #         'member'
    #       ],
    #       map_value: {
    #         'key' => 'value'
    #       },
    #       structure_value: {
    #         hi: 'hi'
    #       }
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::JsonUnionsOutput
    #   resp.data.contents #=> Types::MyUnion, one of [StringValue, BooleanValue, NumberValue, BlobValue, TimestampValue, EnumValue, ListValue, MapValue, StructureValue]
    #   resp.data.contents.string_value #=> String
    #   resp.data.contents.boolean_value #=> Boolean
    #   resp.data.contents.number_value #=> Integer
    #   resp.data.contents.blob_value #=> String
    #   resp.data.contents.timestamp_value #=> Time
    #   resp.data.contents.enum_value #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.contents.list_value #=> Array<String>
    #   resp.data.contents.list_value[0] #=> String
    #   resp.data.contents.map_value #=> Hash<String, String>
    #   resp.data.contents.map_value['key'] #=> String
    #   resp.data.contents.structure_value #=> Types::GreetingStruct
    #   resp.data.contents.structure_value.hi #=> String
    #
    def json_unions(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::JsonUnionsInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::JsonUnionsInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::JsonUnions
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::JsonUnions
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::JsonUnions,
        stubs: @stubs,
        params_class: Params::JsonUnionsOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :json_unions
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::KitchenSinkOperationInput}.
    #
    # @return [Types::KitchenSinkOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.kitchen_sink_operation(
    #     blob: 'Blob',
    #     boolean: false,
    #     double: 1.0,
    #     empty_struct: { },
    #     float: 1.0,
    #     httpdate_timestamp: Time.now,
    #     integer: 1,
    #     iso8601_timestamp: Time.now,
    #     json_value: 'JsonValue',
    #     list_of_lists: [
    #       [
    #         'member'
    #       ]
    #     ],
    #     list_of_maps_of_strings: [
    #       {
    #         'key' => 'value'
    #       }
    #     ],
    #     list_of_structs: [
    #       {
    #         value: 'Value'
    #       }
    #     ],
    #     long: 1,
    #     recursive_list: [
    #       {
    #         blob: 'Blob',
    #         boolean: false,
    #         double: 1.0,
    #         float: 1.0,
    #         httpdate_timestamp: Time.now,
    #         integer: 1,
    #         iso8601_timestamp: Time.now,
    #         json_value: 'JsonValue',
    #         long: 1,
    #         string: 'String',
    #         struct_with_location_name: {
    #           value: 'Value'
    #         },
    #         timestamp: Time.now,
    #         unix_timestamp: Time.now
    #       }
    #     ],
    #     string: 'String',
    #     timestamp: Time.now,
    #     unix_timestamp: Time.now
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::KitchenSinkOperationOutput
    #   resp.data.blob #=> String
    #   resp.data.boolean #=> Boolean
    #   resp.data.double #=> Float
    #   resp.data.empty_struct #=> Types::EmptyStruct
    #   resp.data.float #=> Float
    #   resp.data.httpdate_timestamp #=> Time
    #   resp.data.integer #=> Integer
    #   resp.data.iso8601_timestamp #=> Time
    #   resp.data.json_value #=> String
    #   resp.data.list_of_lists #=> Array<Array<String>>
    #   resp.data.list_of_lists[0] #=> Array<String>
    #   resp.data.list_of_lists[0][0] #=> String
    #   resp.data.list_of_maps_of_strings #=> Array<Hash<String, String>>
    #   resp.data.list_of_maps_of_strings[0] #=> Hash<String, String>
    #   resp.data.list_of_maps_of_strings[0]['key'] #=> String
    #   resp.data.list_of_strings #=> Array<String>
    #   resp.data.list_of_structs #=> Array<SimpleStruct>
    #   resp.data.list_of_structs[0] #=> Types::SimpleStruct
    #   resp.data.list_of_structs[0].value #=> String
    #   resp.data.long #=> Integer
    #   resp.data.map_of_lists_of_strings #=> Hash<String, Array<String>>
    #   resp.data.map_of_maps #=> Hash<String, Hash<String, String>>
    #   resp.data.map_of_strings #=> Hash<String, String>
    #   resp.data.map_of_structs #=> Hash<String, SimpleStruct>
    #   resp.data.recursive_list #=> Array<KitchenSink>
    #   resp.data.recursive_list[0] #=> Types::KitchenSink
    #   resp.data.recursive_list[0].blob #=> String
    #   resp.data.recursive_list[0].boolean #=> Boolean
    #   resp.data.recursive_list[0].double #=> Float
    #   resp.data.recursive_list[0].empty_struct #=> Types::EmptyStruct
    #   resp.data.recursive_list[0].float #=> Float
    #   resp.data.recursive_list[0].httpdate_timestamp #=> Time
    #   resp.data.recursive_list[0].integer #=> Integer
    #   resp.data.recursive_list[0].iso8601_timestamp #=> Time
    #   resp.data.recursive_list[0].json_value #=> String
    #   resp.data.recursive_list[0].list_of_lists #=> Array<Array<String>>
    #   resp.data.recursive_list[0].list_of_maps_of_strings #=> Array<Hash<String, String>>
    #   resp.data.recursive_list[0].list_of_strings #=> Array<String>
    #   resp.data.recursive_list[0].list_of_structs #=> Array<SimpleStruct>
    #   resp.data.recursive_list[0].long #=> Integer
    #   resp.data.recursive_list[0].map_of_lists_of_strings #=> Hash<String, Array<String>>
    #   resp.data.recursive_list[0].map_of_maps #=> Hash<String, Hash<String, String>>
    #   resp.data.recursive_list[0].map_of_strings #=> Hash<String, String>
    #   resp.data.recursive_list[0].map_of_structs #=> Hash<String, SimpleStruct>
    #   resp.data.recursive_list[0].recursive_list #=> Array<KitchenSink>
    #   resp.data.recursive_list[0].recursive_map #=> Hash<String, KitchenSink>
    #   resp.data.recursive_list[0].recursive_struct #=> Types::KitchenSink
    #   resp.data.recursive_list[0].simple_struct #=> Types::SimpleStruct
    #   resp.data.recursive_list[0].string #=> String
    #   resp.data.recursive_list[0].struct_with_location_name #=> Types::StructWithLocationName
    #   resp.data.recursive_list[0].struct_with_location_name.value #=> String
    #   resp.data.recursive_list[0].timestamp #=> Time
    #   resp.data.recursive_list[0].unix_timestamp #=> Time
    #   resp.data.recursive_map #=> Hash<String, KitchenSink>
    #   resp.data.recursive_struct #=> Types::KitchenSink
    #   resp.data.simple_struct #=> Types::SimpleStruct
    #   resp.data.string #=> String
    #   resp.data.struct_with_location_name #=> Types::StructWithLocationName
    #   resp.data.timestamp #=> Time
    #   resp.data.unix_timestamp #=> Time
    #
    def kitchen_sink_operation(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::KitchenSinkOperationInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::KitchenSinkOperationInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::KitchenSinkOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: [Errors::ErrorWithMembers, Errors::ErrorWithoutMembers]),
        data_parser: Parsers::KitchenSinkOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::KitchenSinkOperation,
        stubs: @stubs,
        params_class: Params::KitchenSinkOperationOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :kitchen_sink_operation
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example ensures that mediaType strings are base64 encoded in headers.
    #
    # @param [Hash] params
    #   See {Types::MediaTypeHeaderInput}.
    #
    # @return [Types::MediaTypeHeaderOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.media_type_header(
    #     json: 'json'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::MediaTypeHeaderOutput
    #   resp.data.json #=> String
    #
    def media_type_header(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::MediaTypeHeaderInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::MediaTypeHeaderInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::MediaTypeHeader
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::MediaTypeHeader
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::MediaTypeHeader,
        stubs: @stubs,
        params_class: Params::MediaTypeHeaderOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :media_type_header
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::NestedAttributesOperationInput}.
    #
    # @return [Types::NestedAttributesOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.nested_attributes_operation(
    #     simple_struct: {
    #       value: 'Value'
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::NestedAttributesOperationOutput
    #   resp.data.value #=> String
    #
    def nested_attributes_operation(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::NestedAttributesOperationInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::NestedAttributesOperationInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::NestedAttributesOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::NestedAttributesOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::NestedAttributesOperation,
        stubs: @stubs,
        params_class: Params::NestedAttributesOperationOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :nested_attributes_operation
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Null and empty headers are not sent over the wire.
    #
    # Tags: ["client-only"]
    #
    # @param [Hash] params
    #   See {Types::NullAndEmptyHeadersClientInput}.
    #
    # @return [Types::NullAndEmptyHeadersClientOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.null_and_empty_headers_client(
    #     a: 'a',
    #     b: 'b',
    #     c: [
    #       'member'
    #     ]
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::NullAndEmptyHeadersClientOutput
    #   resp.data.a #=> String
    #   resp.data.b #=> String
    #   resp.data.c #=> Array<String>
    #   resp.data.c[0] #=> String
    #
    def null_and_empty_headers_client(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::NullAndEmptyHeadersClientInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::NullAndEmptyHeadersClientInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::NullAndEmptyHeadersClient
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::NullAndEmptyHeadersClient
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::NullAndEmptyHeadersClient,
        stubs: @stubs,
        params_class: Params::NullAndEmptyHeadersClientOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :null_and_empty_headers_client
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::NullOperationInput}.
    #
    # @return [Types::NullOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.null_operation(
    #     string: 'string',
    #     sparse_string_list: [
    #       'member'
    #     ],
    #     sparse_string_map: {
    #       'key' => 'value'
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::NullOperationOutput
    #   resp.data.string #=> String
    #   resp.data.sparse_string_list #=> Array<String>
    #   resp.data.sparse_string_list[0] #=> String
    #   resp.data.sparse_string_map #=> Hash<String, String>
    #   resp.data.sparse_string_map['key'] #=> String
    #
    def null_operation(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::NullOperationInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::NullOperationInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::NullOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::NullOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::NullOperation,
        stubs: @stubs,
        params_class: Params::NullOperationOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :null_operation
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Omits null, but serializes empty string value.
    #
    # @param [Hash] params
    #   See {Types::OmitsNullSerializesEmptyStringInput}.
    #
    # @return [Types::OmitsNullSerializesEmptyStringOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.omits_null_serializes_empty_string(
    #     null_value: 'nullValue',
    #     empty_string: 'emptyString'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::OmitsNullSerializesEmptyStringOutput
    #
    def omits_null_serializes_empty_string(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::OmitsNullSerializesEmptyStringInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::OmitsNullSerializesEmptyStringInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::OmitsNullSerializesEmptyString
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::OmitsNullSerializesEmptyString
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::OmitsNullSerializesEmptyString,
        stubs: @stubs,
        params_class: Params::OmitsNullSerializesEmptyStringOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :omits_null_serializes_empty_string
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::OperationWithOptionalInputOutputInput}.
    #
    # @return [Types::OperationWithOptionalInputOutputOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.operation_with_optional_input_output(
    #     value: 'Value'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::OperationWithOptionalInputOutputOutput
    #   resp.data.value #=> String
    #
    def operation_with_optional_input_output(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::OperationWithOptionalInputOutputInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::OperationWithOptionalInputOutputInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::OperationWithOptionalInputOutput
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::OperationWithOptionalInputOutput
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::OperationWithOptionalInputOutput,
        stubs: @stubs,
        params_class: Params::OperationWithOptionalInputOutputOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :operation_with_optional_input_output
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Automatically adds idempotency tokens.
    #
    # Tags: ["client-only"]
    #
    # @param [Hash] params
    #   See {Types::QueryIdempotencyTokenAutoFillInput}.
    #
    # @return [Types::QueryIdempotencyTokenAutoFillOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.query_idempotency_token_auto_fill(
    #     token: 'token'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::QueryIdempotencyTokenAutoFillOutput
    #
    def query_idempotency_token_auto_fill(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::QueryIdempotencyTokenAutoFillInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::QueryIdempotencyTokenAutoFillInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::QueryIdempotencyTokenAutoFill
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::QueryIdempotencyTokenAutoFill
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::QueryIdempotencyTokenAutoFill,
        stubs: @stubs,
        params_class: Params::QueryIdempotencyTokenAutoFillOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :query_idempotency_token_auto_fill
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::QueryParamsAsStringListMapInput}.
    #
    # @return [Types::QueryParamsAsStringListMapOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.query_params_as_string_list_map(
    #     qux: 'qux',
    #     foo: {
    #       'key' => [
    #         'member'
    #       ]
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::QueryParamsAsStringListMapOutput
    #
    def query_params_as_string_list_map(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::QueryParamsAsStringListMapInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::QueryParamsAsStringListMapInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::QueryParamsAsStringListMap
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::QueryParamsAsStringListMap
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::QueryParamsAsStringListMap,
        stubs: @stubs,
        params_class: Params::QueryParamsAsStringListMapOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :query_params_as_string_list_map
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::StreamingOperationInput}.
    #
    # @return [Types::StreamingOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.streaming_operation(
    #     output: 'output'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::StreamingOperationOutput
    #   resp.data.output #=> String
    #
    def streaming_operation(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::StreamingOperationInput.build(params)
      response_body = output_stream(options, &block)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::StreamingOperationInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::StreamingOperation
      )
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::StreamingOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::StreamingOperation,
        stubs: @stubs,
        params_class: Params::StreamingOperationOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :streaming_operation
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example tests how timestamp request and response headers are serialized.
    #
    # @param [Hash] params
    #   See {Types::TimestampFormatHeadersInput}.
    #
    # @return [Types::TimestampFormatHeadersOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.timestamp_format_headers(
    #     member_epoch_seconds: Time.now,
    #     member_http_date: Time.now,
    #     member_date_time: Time.now,
    #     default_format: Time.now,
    #     target_epoch_seconds: Time.now,
    #     target_http_date: Time.now,
    #     target_date_time: Time.now
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::TimestampFormatHeadersOutput
    #   resp.data.member_epoch_seconds #=> Time
    #   resp.data.member_http_date #=> Time
    #   resp.data.member_date_time #=> Time
    #   resp.data.default_format #=> Time
    #   resp.data.target_epoch_seconds #=> Time
    #   resp.data.target_http_date #=> Time
    #   resp.data.target_date_time #=> Time
    #
    def timestamp_format_headers(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::TimestampFormatHeadersInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::TimestampFormatHeadersInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::TimestampFormatHeaders
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::TimestampFormatHeaders
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::TimestampFormatHeaders,
        stubs: @stubs,
        params_class: Params::TimestampFormatHeadersOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :timestamp_format_headers
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::Struct____789BadNameInput}.
    #
    # @return [Types::Struct____789BadNameOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.operation____789_bad_name(
    #     member___123abc: '__123abc', # required
    #     member: {
    #       member___123foo: '__123foo'
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::Struct____789BadNameOutput
    #   resp.data.member #=> Types::Struct____456efg
    #   resp.data.member.member___123foo #=> String
    #
    def operation____789_bad_name(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::Struct____789BadNameInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::Struct____789BadNameInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::Operation____789BadName
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::Operation____789BadName
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::Operation____789BadName,
        stubs: @stubs,
        params_class: Params::Struct____789BadNameOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @config.endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :operation____789_bad_name
        )
      )
      raise resp.error if resp.error
      resp
    end

    private

    def apply_middleware(middleware_stack, middleware)
      Client.middleware.apply(middleware_stack)
      @middleware.apply(middleware_stack)
      Hearth::MiddlewareBuilder.new(middleware).apply(middleware_stack)
    end

    def output_stream(options = {}, &block)
      return options[:output_stream] if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      ::StringIO.new
    end
  end
end
