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
    end



    test "1.1.2 a title should be unique within a conference" do
    end



    test "1.2.1 a description should not be empty" do
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    test "2.1 should belong to a single sender" do
    end



    test "2.2 should reference a single topic" do
    end



    test "2.3 should reference a single conference" do
    end



    test "2.4 should have many reviews" do
    end



    test "2.5 should have many reviewers" do
    end

  end

end
