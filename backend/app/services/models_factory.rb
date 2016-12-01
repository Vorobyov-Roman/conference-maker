class ModelsFactory

  def create name, params = {}
    model(name).create params
  end

private

  def model name
    reslove_alias(name).classify.constantize
  end

  def reslove_alias name
    case name
    when :updated_application
      "application"
    else
      "#{name}"
    end
  end

end
