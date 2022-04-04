# frozen_string_literal: true

module Hearth
  module Middleware
    describe ResponseHandler do
      let(:app) { double('app', call: output) }
      let(:handler) { double('handler') }

      subject do
        ResponseHandler.new(
          app,
          handler: handler
        )
      end

      describe '#call' do
        let(:input) { double('input') }
        let(:output) { double('output') }
        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:context) do
          Context.new(
            request: request,
            response: response
          )
        end

        it 'calls the next middleware and then the handler' do
          expect(app).to receive(:call)
            .with(input, context).and_return(output).ordered

          expect(handler).to receive(:call)
            .with(output, context).ordered

          resp = subject.call(input, context)
          expect(resp).to be output
        end
      end
    end
  end
end