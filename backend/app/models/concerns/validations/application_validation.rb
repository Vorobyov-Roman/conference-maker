module Validations::ApplicationValidation

  def self.included mixee
    mixee.validates :description, description_validation
    mixee.validate  :unique_title_in_conference
  end

private

  def self.description_validation
    absent = "The description should not be empty"

    {
      presence: { message: absent }
    }
  end

  def unique_title_in_conference
    return unless title_changed? || new_record?

    absent = "The title should not be empty"
    taken   = "This title is already taken"

    if title.blank?
      errors.add :title, absent
    end

    if conference.applications.collect(&:title).include? title
      errors.add :title, taken
    end
  end

end
