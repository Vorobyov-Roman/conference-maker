class Queries::ModelsValidator

  def initialize factory
    @factory = factory
  end

  def valid? model, *params
    messages = check model, *params
    messages == {}
  end

  def check model, *params
    record = @factory.create model, *params

    record.valid?
    record.errors.messages
  end

end
