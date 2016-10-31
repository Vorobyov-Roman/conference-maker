require 'test_helper'
require 'validation_test_helper'
require 'association_test_helper'

=begin

1 Validation
  1.1 Title
    1.1.1 should not be empty
    1.1.2 should be unique
  1.2 Description
    1.2.1 should not be empty

2 Associations
  2.1 should belong to a single creator
  2.2 should have many organizers
  2.3 should have many topics

=end

module ConferenceTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
      title_empty:       "The title should not be empty",
      title_taken:       "This title is already taken",

      description_empty: "The description should not be empty"
    }

    def expect_message message_code
      super MESSAGES[message_code]
    end

    def reset_current_conference
      reset_current_record Conference do |c|
        c.title =       "valid title"
        c.description = "valid description"

        c.creator = users(:illuminati)
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
      assert_validation_success :description, "valid description"
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    include AssociationTestHelper

    test "2.1: should belong to a single creator" do
      creator = users(:illuminati)

      assert_equal conferences(:trump_rally).creator, creator

      assert_inverse_of_many creator, :created_conferences, :creator
    end



    test "2.2: should have many organizers" do
      # plural name implies a collection
      organizers = conferences(:trump_rally).organizers

      assert_includes organizers, users(:trump)
    end



    test "2.3: should have many topics" do
      conference_topics = conferences(:trump_rally).topics

      assert_includes conference_topics, topics(:wall_building)
      assert_includes conference_topics, topics(:china)
    end

  end

end
