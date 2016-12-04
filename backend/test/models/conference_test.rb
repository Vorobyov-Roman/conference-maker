require 'test_helper'
require 'validation_test_helper'

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
  2.4 should have many applications
  2.5 should have many attendees

=end

module ConferenceTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
      title_empty:       "The title should not be empty",
      title_taken:       "This title is already taken",

      description_empty: "The description should not be empty"
    }



    test "1.1.1 a title should not be empty" do
      assert_invalid :title, MESSAGES[:title_empty], nil, ""
      assert_valid :title, "valid title"
    end



    test "1.1.2 a title should be unique" do
      using strategy: :create
      assert_valid :title, "dummy title"

      using strategy: :build
      assert_invalid :title, MESSAGES[:title_taken], "dummy title"
    end



    test "1.2.1 a description should not be empty" do
      assert_invalid :description, MESSAGES[:description_empty], nil, ""
      assert_valid :description, "valid description"
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    test "2.1 should belong to a single creator" do
      user = build :user
      conference = build :conference, creator: user

      assert_same conference.creator, user
    end



    test "2.2 should have many organizers" do
      conference = build :conference, organizers_count: 2
      assert_equal 2, conference.organizers.count
    end



    test "2.3 should have many topics" do
      conference = build :conference, topics_count: 3
      assert_equal 3, conference.topics.count
    end



    test "2.4 should have many applications" do
      topic1 = build :topic, applications_count: 2
      topic2 = build :topic, applications_count: 3
      conference = create :conference, topics: [topic1, topic2]

      assert_equal 5, conference.applications.count
    end



    test "2.5 should have many attendees" do
      conference = build :conference, attendees_count: 4
      assert_equal 4, conference.attendees.count
    end

  end

end
