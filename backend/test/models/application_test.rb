require 'test_helper'
require 'validation_test_helper'

=begin

1 Validation
  1.1 Title
    1.1.1 should not be empty
    1.1.2 should be unique within a conference
  1.2 Description
    1.2.1 should not be empty

2 Associations
  2.1 should belong to a single sender
  2.2 should reference a single topic
  2.3 should reference a single conference
  2.4 should have many reviews
  2.5 should have many reviewers

=end

module ApplicationTest

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



    test "1.1.2 a title should be unique within a conference" do
      conference1 = build :conference
      conference2 = build :conference
      topic1 = build :topic, conference: conference1
      topic2 = build :topic, conference: conference2
      topic3 = build :topic, conference: conference2

      using strategy: :create, topic: topic1
      assert_valid :title, "dummy title"

      using topic: topic2
      assert_valid :title, "dummy title"

      using strategy: :build, topic: topic3
      assert_invalid :title, MESSAGES[:title_taken], "dummy title"
    end



    test "1.2.1 a description should not be empty" do
      assert_invalid :description, MESSAGES[:description_empty], nil, ""
      assert_valid :description, "valid description"
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    test "2.1 should belong to a single sender" do
      user = build :user
      application = build :application, sender: user

      assert_same application.sender, user
    end



    test "2.2 should reference a single topic" do
      topic = build :topic
      application = build :application, topic: topic

      assert_same application.topic, topic
    end



    test "2.3 should reference a single conference" do
      conference = build :conference
      application = build(
        :application,
        topic: build(:topic, conference: conference)
      )

      assert_same application.conference, conference
    end



    test "2.4 should have many reviews" do
      application = build :application, reviews_count: 2
      assert_equal 2, application.reviews.count
    end



    test "2.5 should have many reviewers" do
      application = build :application, reviews_count: 3
      assert_equal 3, application.reviewers.count
    end

  end

end
