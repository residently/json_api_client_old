module JsonApiClient
  module Helpers
    module Debug
      def self.included(_base)
        $_resource_attribute_calls = {}
      end

      def track_resource_attribute_calls
        yield
      ensure
        puts '----------------------------------------------------------'
        pp $_resource_attribute_calls
        puts '----------------------------------------------------------'
      end
    end
  end
end
