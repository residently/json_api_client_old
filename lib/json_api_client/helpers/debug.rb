module JsonApiClient
  module Helper
    module Debug
      def track_resource_attribute_calls
        $_resource_attribute_calls = {}
        yield
        puts '----------------------------------------------------------'
        pp $_resource_attribute_calls
        puts '----------------------------------------------------------'
        $_resource_attribute_calls = nil # To avoid risk of memory leaks
      end
    end
  end
end
