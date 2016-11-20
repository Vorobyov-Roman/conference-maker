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
  2.1 should belong to a single conference
  2.2 should have many moderators
  2.3 should have many applications

=end

module TopicTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
      title_empty: "The title should not be empty",
      title_taken: "This title is already taken",

      description_empty: "The description should not be empty"
    }



    test "1.1.1 a title should not be empty" do
      assert_invalid :title, MESSAGES[:title_empty], nil, ""
      assert_valid :title, "valid title"
    end



    test "1.1.2 a title should be unique within a conference" do
      conference1 = build :conference
      conference2 = build :conference

      using strategy: :create, conference: conference1
      assert_valid :title, "dummy title"

      using conference: conference2
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

    test "2.1 should belong to a single conference" do
      conference = build :conference
      topic = build :topic, conference: conference

      assert_same topic.conference, conference
    end



    test "2.2 should have many moderators" do
      topic = build :topic, moderators_count: 2
      assert_equal topic.moderators.size, 2
    end



    test "2.3 should have many applications" do
    end

  end

end
