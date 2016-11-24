class ModelsFactory

  def create model, params = {}
    "#{model}".classify.constantize.create params
  end

end