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
        read_attribute(key)
      end

      def []=(key, value)
        normalized_key = normalize_name(key)
        set_attribute(normalized_key, value)
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

      def normalize_name(name)
        if key_formatter
          key_formatter.unformat(name.to_s)
        else
          name.to_s
        end
      end

      def method_missing(method, *args, &block)
        normalized_method = normalize_name(method)

        if normalized_method =~ /^(.*)=$/
          set_attribute($1, args.first)
        elsif has_attribute?(method)
          attributes[method]
        else
          super
        end
      end

      def read_attribute(name)
        attributes.fetch(name, nil)
      end

      def set_attribute(name, value)
        attributes[name] = value
      end

      def key_formatter
        self.class.respond_to?(:key_formatter) && self.class.key_formatter
      end

    end
  end
end
