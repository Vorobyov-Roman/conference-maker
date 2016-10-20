class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  def self.inherited subclass
    super

    subclass.include Validations
    subclass.include Associations
  end

end
