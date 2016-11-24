require 'active_support/concern'

module Validations

  extend ActiveSupport::Concern

  included do
    begin
      include const_get "Validations::#{self.name}Validation"
    rescue NameError
      message = "The validations are not provided for the #{self.name} model."
      warn message.yellow
    end
  end

end
