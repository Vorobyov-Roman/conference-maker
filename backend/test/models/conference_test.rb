require 'test_helper'
require 'validation_test_helper'

=begin

1 Validation
  1.1 Title
    1.1.1 should not be empty
    1.1.2 should be unique
  1.2 Description
    1.2.1 should not be empty

2 Association
  2.1 Organizer
    2.1.1 should be a many-to-many association
    2.1.2 should be inverse of user's organized conferences

=end

module ConferenceTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
      title_empty: "The title should not be empty",
      title_taken: "This title is already taken",

      description_empty: "The description should not be empty"
    }

    def expect_message message_code
      super MESSAGES[message_code]
    end

    def reset_current_conference
      reset_current_record do
        Conference.new do |c|
          c.title = "valid title"
          c.description = "valid description"
        end
      end
    end

    def setup
      reset_current_conference
    end

    def teardown
      Conference.delete_all
      Rails.cache.clear
    end


    test "1.1.1: a title should not be empty" do
      expect_message :title_empty

      assert_validation_failure :title, nil, ""
      assert_validation_success :title, "valid title"
    end


    test "1.1.2: a title should be unique" do
      expect_message :title_taken

      assert_validation_success :title

      reset_current_conference
      assert_validation_failure :title
    end


    test "1.2.1 a description should not be empty" do
      expect_message :description_empty

      assert_validation_failure :description, nil, ""
      assert_validation_success :description, "valid title"
    end

  end



  class AssociationTest < ActiveSupport::TestCase



  end

end
