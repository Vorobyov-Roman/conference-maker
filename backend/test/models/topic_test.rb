require 'test_helper'
require 'validation_test_helper'
require 'association_test_helper'

=begin

1 Validation
  1.1 Title
    1.1.1 should not be empty
    1.1.2 should be unique within a conference
  1.2 Description
    1.2.1 should not be empty

2 Associations
  2.1 should have many moderators
  2.2 should belong to a single conference

=end

module TopicTest

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

    def reset_current_topic conference = :first
      reset_current_record Topic do |t|
        t.title =       "valid title"
        t.description = "valid description"

        t.conference =  conferences(conference)
      end
    end

    def setup
      reset_current_topic
    end

    def teardown
      Topic.delete_all
      Rails.cache.clear
    end



    test "1.1.1 a title should not be empty" do
      expect_message :title_empty

      assert_validation_failure :title, nil, ""
      assert_validation_success :title, "valid title"
    end



    test "1.1.2 a title should be unique within a conference" do
      expect_message :title_taken

      assert_validation_success :title

      reset_current_topic
      assert_validation_failure :title

      reset_current_topic :second
      assert_validation_success :title      
    end



    test "1.2.1 a description should not be empty" do
      expect_message :description_empty

      assert_validation_failure :description, nil, ""
      assert_validation_success :description, "valid description"
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    include AssociationTestHelper

    test "2.1 should have many moderators" do
      moderators = topics(:sixth).moderators

      assert_includes moderators, users(:first)
      assert_includes moderators, users(:fifth)
    end



    test "2.2 should belong to a single conference" do
      conference = conferences(:first)

      assert_equal topics(:first).conference, conference

      assert_inverse_of_many conference, :topics, :conference
    end

  end

end
