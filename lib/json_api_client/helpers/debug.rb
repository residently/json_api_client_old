module JsonApiClient
  module Helpers
    module Debug
      def track_resource_attribute_calls
        $_resource_attribute_calls = {}
        yield
        puts '----------------------------------------------------------'
        pp $_resource_attribute_calls
        puts '----------------------------------------------------------'
      end
    end
  end
end
