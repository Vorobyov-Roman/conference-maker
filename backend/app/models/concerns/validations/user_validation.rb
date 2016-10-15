require 'active_support/concern'

module UserValidation
  extend ActiveSupport::Concern

  included do
    UserValidation.name_validations.each { |v| validates :name, v }
    UserValidation.email_validations.each { |v| validates :email, v }
    UserValidation.login_validations.each { |v| validates :login, v }
    UserValidation.password_validations.each { |v| validates :password, v }
  end

  def self.name_validations
    too_short = "The name should be at least %{count} characters long"
    invalid_characters = "The name should only contain letters and spaces"
    space_at_the_end = "The name should not begin or end with a space"
    spaces_in_a_row = "The name should not contain several spaces in a row"

    [
      {
        length: { minimum: 5, too_short: too_short },
        format: { with: /\A[a-zA-Z\s]+\z/, message: invalid_characters }
      },
      {
        format: { without: /(\A\s)|(\s\z)/, message: space_at_the_end }
      },
      {
        format: { without: /\s{2,}/, message: spaces_in_a_row }
      }
    ]
  end

  def self.email_validations
    invalid_address = "The email should be a valid address"
    taken = "This email is already taken"

    [
      {
        format: { with: /\A[^@]+@[^@]+\z/, message: invalid_address },
        uniqueness: { message: taken }
      }
    ]
  end

  def self.login_validations
    taken = "This login is already taken"
    too_short = "The login should be at least 5 characters long"
    invalid_characters = "The login should not contain special characters"

    [
      {
        uniqueness: { message: taken },
        length: { minimum: 5, too_short: too_short },
        format: { with: /[a-zA-Z0-9\-_]+/, message: invalid_characters }
      }
    ]
  end

  def self.password_validations
    too_short = "The password should be at least 5 characters long"

    [
      {
        length: { minimum: 5, too_short: too_short }
      }
    ]
  end
end
