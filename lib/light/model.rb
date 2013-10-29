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
          self.send(:attr_accessor, attr)
        end
        @__attributes = (@__attributes || []) + attrs
      end
    end

    def equality_state
      self.class.instance_variable_get(:@__attributes).map do |attr|
        public_send("#{attr}")
      end
    end

    def ==(o)
      o.class == self.class && o.equality_state == equality_state
    end

    alias_method :eql?, :==

    def hash
      equality_state.hash
    end

    def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
    end

    def to_h(opts=nil)
      self.serializable_hash(opts)
    end

    def persisted?
      false
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