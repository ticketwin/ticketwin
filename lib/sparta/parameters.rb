require_relative 'errors'

module Sparta
  class Parameters
    attr_reader :params

    def initialize(params)
      @params = params
    end

    class << self
      def action(method, options, &block)
        sparta = registry[method][[options[:require], true]]
        sparta.instance_eval(&block)

        define_method(method) do
          self.class.registry[method].validate(params)
        end
      end

      def registry
        @registry ||= Registry.new
      end
    end

    class Registry
      attr_reader :registry

      def initialize
        @registry = {}.with_indifferent_access
      end

      def validate(params)
        params = params.symbolize_keys
        params.each do |key, value|
          dig = validate!(key)
          if value.is_a? Hash
            binding.pry
            dig.validate(value)
          end
        end
      end

      def validate_permitted(param)
        if registry.key? [param, true]
          registry[[param, true]]
        elsif registry.key? [param, false]
          registry[[param, false]]
        elsif registry.key? param
          true
        else
          raise UnpermittedParameter, param
        end
      end

      def validate_required
      end

      delegate :key?, to: :registry

      def [](key)
        registry[key] ||= self.class.new
      end

      def require(attribute, &block)
        add_node(attribute, true, &block)
      end

      def permit(attribute, &block)
        add_node(attribute, false, &block)
      end

      def add_node(attribute, required, &block)
        if block.present?
          registry[[attribute, required]] = self.class.new.instance_eval(&block)
        else
          registry[attribute] = required
        end
      end
    end
  end
end
