class ApplicationController < ActionController::API

  include ErrorHandling

protected

  def factory strategy = :create!
    @factory ||= Factories::ModelsFactory.new strategy
  end

  def managers_provider
    @managers_provider ||= Factories::ManagersProvider.new factory
  end

  def jwt_wrapper
    @jwt_wrapper ||= Tools::JWTHelper.new UserSerializer
  end

  def validator
    @validator ||= Queries::ModelsValidator.new factory(:new)
  end

end
