require 'active_model'
module Light
  class Model
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON
    extend  ActiveModel::Naming
    extend  ActiveModel::Translation
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveSupport::Concern

    class << self
      def attributes(*attrs)
        attrs.each do |attr|
          send(:attr_accessor, attr)
        end
        @__attributes = (@__attributes || []) + attrs
      end

      def persisted_via_attr(attr_name)
        @__persisted_via_attr = attr_name
      end
    end

    def equality_state
      self.class.instance_variable_get(:@__attributes).map do |attr|
        public_send(attr.to_s)
      end
    end

    def ==(other)
      other.class == self.class && other.equality_state == equality_state
    end

    alias eql? ==

    def hash
      equality_state.hash
    end

    def initialize(params = {})
      return unless params
      params.each do |attr, value|
        public_send("#{attr}=", value)
      end
    end

    def to_h(opts = nil)
      serializable_hash(opts)
    end

    def persisted?
      attr_name = self.class.instance_variable_get(:@__persisted_via_attr)
      return false if attr_name.nil?
      value = send(attr_name)
      !(value.respond_to?(:empty?) ? !!value.empty? : !value)
    end

    private

    def attributes
      {}.tap do |h|
        (self.class.instance_variable_get(:@__attributes) || []).map do |key|
          h[key.to_s] = public_send(key.to_sym)
        end
      end
    end
  end
end
