class ApplicationController < ActionController::API

  include ErrorHandling

protected

  def serializer
    Tools::Serializer.new
  end

  def factory strategy = :create!
    Factories::ModelsFactory.new strategy
  end

  def managers_provider
    Factories::ManagersProvider.new factory
  end

  def jwt_wrapper
    Tools::JWTHelper.new serializer
  end

  def validator
    Queries::ModelsValidator.new factory(:new)
  end

end
