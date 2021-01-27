# frozen_string_literal: true

module Seahorse

  # A utility class for registering middleware for a request.
  # You register middleware handlers to execute at key request
  # lifecycle events including:
  #
  # * build
  # * sign
  # * send
  # * parse
  # * retry
  #
  # You can register request handlers that invoke before, after,
  # or around each lifecycle events. These handlers are
  # request, response, or around handlers.
  #
  # ## Request Handlers
  #
  # A request handler is invoked before the request is sent.
  #
  #    # invoked after a request has been built, but before it has
  #    # been signed/authorized
  #    middleware.before_sign do |http_req, http_resp, metadata|
  #      # do something here
  #    end
  #
  # The complete list of request handlers include:
  #
  # * {#before_build}
  # * {#after_build}
  # * {#before_sign}
  # * {#after_sign}
  # * {#before_send}
  #
  # ## Response Handlers
  #
  # A response handler is invoked after the HTTP request has been sent
  # and a HTTP response has been received.
  #
  #    # invoked after the HTTP response has been parsed
  #    middleware.after_parse do |response, http_req, http_resp|
  #      # response.data
  #      # response.error
  #      # response.metadata
  #    end
  #
  # The complete list of response handlers include:
  #
  # * {#after_send}
  # * {#before_parse}
  # * {#after_parse}
  # * {#before_retry}
  # * {#after_retry}
  #
  # ## Around Handlers
  #
  # Around handlers see a request before it has been sent along
  # with the response returned. Around handlers must invoke `#call`
  # method of the next middleware in the stack. Around handlers
  # must also return the response returned from the next middleware.
  #
  #     # invoke before the request  has been sent, receives the
  #     # response from the send middleware
  #     middleware.around_send do |app, http_req, http_resp, metadata|
  #
  #       # this code is invoked before the request is sent
  #       # ...
  #
  #       # around handlers must call the next middleware in the stack
  #       response = app.call(
  #         http_req: http_req,
  #         http_resp: http_resp,
  #         metadata: metadata
  #       )
  #
  #       # this code is invoked after the response has been received
  #       # ...
  #
  #       # around handlers must return the response down the stack
  #       response
  #     end
  #
  # The complete list of around handlers include:
  #
  # * {#around_build}
  # * {#around_retry}
  # * {#around_parse}
  # * {#around_sign}
  # * {#around_send}
  #
  class MiddlewareBuilder

    # @private
    BOTH = 'expected a handler or a Proc, got both'

    # @private
    NEITHER = 'expected a handler or a Proc, got neither'

    # @private
    TOO_MANY = 'wrong number of arguments (given %<count>d, expected 0 or 1)'

    # @private
    CALLABLE = 'expected handler to respond to #call'

    # @param [Proc, MiddlewareBuilder] middleware
    #
    #   If `middleware` is a Proc, then this builder is yielded to the
    #   Proc object via `#call`.
    #
    #   If `middleware` is another {MiddlewareBuilder} instance, then
    #   the middleware handlers are copied.
    #
    def initialize(middleware = nil)
      @middleware = []
      case middleware
      when MiddlewareBuilder then @middleware.concat(middleware.to_a)
      when Proc then middleware.call(self)
      when nil
      else
        raise ArgumentError, 'expected :middleware to be a Proc or a' \
          "Seahorse::MiddlewareBuilder, got #{middleware.class}"
      end
    end

    # @param [MiddlewareStack] middleware_stack
    def apply(middleware_stack)
      @middleware.each do |handler|
        middleware_stack.send(*handler)
      end
    end

    # Register a handler that is invoked before the request is built.
    # Changes to the `http_req` may be overridden during the actual
    # request build step. The `http_resp` will be empty.
    #
    # @overload before_build(&block)
    #   @yield [http_req, http_resp, metadata]
    #   @yieldparam [NawsHttp::Request] http_req
    #   @yieldparam [NawsHttp::Response] http_resp
    #   @yieldparam [Hash] metadata
    #   @yieldreturn [void]
    #
    # @overload before_build(request_handler)
    #   @param [Proc, #call] request_handler
    #     The request handler must respond to `#call` accepting
    #     three arguments:
    #
    #     * `http_req` ({NawsHttp::Request})
    #     * `http_resp` ({NawsHttp::Response})
    #     * `metadata` (Hash)
    #
    def before_build(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Build,
        Middleware::RequestHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def around_build(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Build,
        Middleware::AroundHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def after_build(*args, &block)
      @middleware << [
        :use_after,
        Seahorse::Middleware::Build,
        Middleware::RequestHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def before_sign(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Sign,
        Middleware::RequestHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def around_sign(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Sign,
        Middleware::AroundHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def after_sign(*args, &block)
      @middleware << [
        :use_after,
        Seahorse::Middleware::Sign,
        Middleware::RequestHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def before_send(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Send,
        Middleware::RequestHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def around_send(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Send,
        Middleware::AroundHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def after_send(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Send,
        Middleware::ResponseHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def before_parse(*args, &block)
      @middleware << [
        :use_after,
        Seahorse::Middleware::Parse,
        Middleware::ResponseHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def around_parse(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Parse,
        Middleware::AroundHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def after_parse(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Parse,
        Middleware::ResponseHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def before_retry(*args, &block)
      @middleware << [
        :use_after,
        Seahorse::Middleware::Retry,
        Middleware::ResponseHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def around_retry(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Retry,
        Middleware::AroundHandler,
        handler_or_proc!(args, &block)
      ]
    end

    def after_retry(*args, &block)
      @middleware << [
        :use_before,
        Seahorse::Middleware::Retry,
        Middleware::ResponseHandler,
        handler_or_proc!(args, &block)
      ]
    end

    private

    def to_a
      @middleware
    end

    def handler_or_proc!(args, &block)
      raise ArgumentError, BOTH if args.size > 0 && block
      raise ArgumentError, NEITHER if args.empty? && block.nil?
      raise ArgumentError, format(TOO_MANY, count: args.size) if args.size > 1
      callable = args.first || Proc.new
      raise ArgumentError, CALLABLE unless callable.respond_to?(:call)
      callable
    end

  end
end