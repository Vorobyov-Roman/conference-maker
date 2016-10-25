module Validations::ConferenceValidation

  def self.included mixee
    mixee.validates :title,       title_validation
    mixee.validates :description, description_validation
  end

private

  def self.title_validation
    abscent = "The title should not be empty"
    taken =   "This title is already taken"

    {
      presence:   { message: abscent },
      uniqueness: { message: taken }
    }
  end

  def self.description_validation
    abscent = "The description should not be empty"

    {
      presence: { message: abscent }
    }
  end

end
