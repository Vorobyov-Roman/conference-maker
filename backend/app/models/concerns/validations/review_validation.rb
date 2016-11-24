module Validations::ReviewValidation

  def self.included mixee
    mixee.validates :comment, comment_validation
  end

private

  def self.comment_validation
    absent = "The comment should not be empty"

    {
      presence: { message: absent }
    }
  end

end
