require 'test_helper'
require 'validation_test_helper'

=begin

1 Validation
  1.1 Name
    1.1.1 should be at least 5 characters long
    1.1.2 should only contain letters and spaces
    1.1.3 should not begin or end with a space
    1.1.4 should mot contain more than 1 space in a row
  1.2 Email
    1.2.1 should be a valid address
    1.2.2 should be unique
  1.3 Login
    1.3.1 should be unique
    1.3.2 should be at least 5 characters long
    1.3.3 should not contain special characters
  1.4 Password
    1.4.1 should be at least 5 characters long

2 Associations
  2.1 Can have many organized conferences

=end

module UserTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
      name_too_short:       "The name should be at least 5 characters long",
      name_not_a_word:      "The name should only contain letters and spaces",
      name_space_at_edge:   "The name should not begin or end with a space",
      name_spaces:          "The name can only have a single space in a row",

      email_invalid:        "The email should be a valid address",
      email_taken:          "This email is already taken",

      login_taken:          "This login is already taken",
      login_too_short:      "The login should be at least 5 characters long",
      login_bad_characters: "The login should not contain special characters",

      password_too_short:   "The password should be at least 5 characters long"
    }

    def expect_message message_code
      super MESSAGES[message_code]
    end

    def reset_current_user
      reset_current_record do
        User.new do |u|
          u.name     = "valid name"
          u.email    = "valid@email"
          u.login    = "valid_login"
          u.password = "valid_password"
        end
      end
    end

    def setup
      reset_current_user
    end

    def teardown
      User.delete_all
      Rails.cache.clear
    end



    test "1.1.1: a name should be at least 5 characters long" do
      expect_message :name_too_short

      assert_validation_failure :name, nil, "", "aaaa"
      assert_validation_success :name, "validname"
    end



    test "1.1.2: a name should only contain letters and spaces" do
      expect_message :name_not_a_word

      assert_validation_failure :name, "0_-"
      assert_validation_success :name, "valid name"
    end



    test "1.1.3: a name should not begin or end with a space" do
      expect_message :name_space_at_edge

      assert_validation_failure :name, " ", " a", "a ", " a "
    end



    test "1.1.4: a name should contain no more than 1 space in a row" do
      expect_message :name_spaces

      assert_validation_failure :name, "a  a"
      assert_validation_success :name, "v a l i d n a m e"
    end



    test "1.2.1: an email should be a valid address" do
      expect_message :email_invalid

      assert_validation_failure :email, "", " ", "invalid", "i@val@d"
      assert_validation_success :email, "valid@email"
    end



    test "1.2.2: an email should be unique" do
      expect_message :email_taken

      assert_validation_success :email

      reset_current_user
      assert_validation_failure :email
    end



    test "1.3.1: a login should be unique" do
      expect_message :login_taken

      assert_validation_success :login

      reset_current_user
      assert_validation_failure :login
    end



    test "1.3.2: a login should be at least 5 characters long" do
      expect_message :login_too_short

      assert_validation_failure :login, nil, "", "aaaa"
      assert_validation_success :login, "validlogin"
    end



    test "1.3.3: a login should not contain special characters" do
      expect_message :login_bad_characters

      assert_validation_failure :login, %Q{`~!@#$%^&*()=+\ |'";:/?.>,<}
      assert_validation_success :login, "lo_gin", "lo-gin", "lo.gin", "l0gin"
    end



    test "1.4.1: a password should be at least 5 characters long" do
      expect_message :password_too_short

      assert_validation_failure :password, nil, "", "aaaa"
      assert_validation_success :password, "validpassword"
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    test "2.1: can have many organized conferences" do
      organized_conferences = users(:illuminati).organized_conferences

      assert_includes organized_conferences, conferences(:trump_rally)
      assert_includes organized_conferences, conferences(:hillary_rally)
    end

  end

end
