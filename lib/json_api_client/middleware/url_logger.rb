module JsonApiClient
  module Middleware
    class UrlLogger < Faraday::Middleware
      def initialize(app, options)
        super(app)
        @name = options[:name]
      end

      def call(request_env)
        log "method: #{request_env[:method]}"
        log "url: #{CGI.unescape(request_env[:url].request_uri)}"

        @app.call(request_env).on_complete do; end
      end

      private

      def log(message)
        Rails.logger.info "[UrlLogger][#{@name}] - "+message
      end
    end
  end
end

