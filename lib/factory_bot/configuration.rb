module FactoryBot
  # @api private
  class Configuration
    attr_reader :factories, :sequences, :traits, :strategies, :callback_names

    attr_accessor :allow_class_lookup, :use_parent_strategy

    def initialize
      @factories      = Decorator::DisallowsDuplicatesRegistry.new(Registry.new("Factory"))
      @sequences      = Decorator::DisallowsDuplicatesRegistry.new(Registry.new("Sequence"))
      @traits         = Decorator::DisallowsDuplicatesRegistry.new(Registry.new("Trait"))
      @strategies     = Registry.new("Strategy")
      @callback_names = Set.new
      @definition     = Definition.new(:configuration)

      @allow_class_lookup = true

      to_create(&:save!)
      initialize_with { new }
    end

    delegate :to_create, :skip_create, :constructor, :before, :after,
      :callback, :callbacks, to: :@definition

    def initialize_with(&block)
      @definition.define_constructor(&block)
    end
  end
end
