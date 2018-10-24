module JsonApiClient
  module Helpers
    module DynamicAttributes

      def attributes
        @attributes
      end

      def attributes=(attrs = {})
        @attributes ||= ActiveSupport::HashWithIndifferentAccess.new

        return @attributes unless attrs.present?
        attrs.each do |key, value|
          self[key] = value
        end
      end

      def [](key)
        attributes.fetch(key, nil)
      end

      def []=(key, value)
        attributes[key] = value
      end

      def respond_to_missing?(method, include_private = false)
        if (method.to_s =~ /^(.*)=$/) || has_attribute?(method)
          true
        else
          super
        end
      end

      def has_attribute?(attr_name)
        attributes.has_key?(attr_name)
      end

      protected

      def method_missing(method, *args, &block)
        if method.to_s =~ /^(.*)=$/
          self[$1] = args.first
        elsif has_attribute?(method)
          attributes[method]
        else
          super
        end
      end

      def key_formatter
        self.class.respond_to?(:key_formatter) && self.class.key_formatter
      end

    end
  end
end
