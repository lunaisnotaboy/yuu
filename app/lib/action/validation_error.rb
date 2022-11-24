class Action
  # TODO: remove own `validate!` and replace with `ActiveModel#validate!`
  class ValidationError < StandardError
    attr_reader :model

    def initialize(model)
      @model = model

      super('Model invalid')
    end
  end
end
