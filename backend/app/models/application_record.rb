class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  def self.inherited subclass
    super

    subclass.include Validations
    subclass.include Associations
  end

protected

  def factory
    Factories::ModelsFactory.new
  end

  def managers_provider
    Factories::ManagersProvider.new factory
  end

end
