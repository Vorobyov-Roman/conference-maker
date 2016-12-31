class Factories::ModelsFactory

  def initialize strategy
    @strategy = strategy
  end

  def create name, params = {}
    model(name).send @strategy, params
  end

private

  def model name
    reslove_alias(name).classify.constantize
  end

  def reslove_alias name
    case name

      when :updated_application,
           :accepted_application,
           :rejected_application,
           :disputable_application
        "application"

      else
        "#{name}"

    end
  end

end
