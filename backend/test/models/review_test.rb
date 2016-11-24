require 'test_helper'
require 'validation_test_helper'

=begin

1 Validation
  1.1 Comment
    1.1.1 should not be empty

2 Associations
  2.1 should reference one reviewer
  2.2 should reference one application

=end

module ReviewTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
      comment_empty: "The comment should not be empty"
    }



    test "1.1.1 a comment should not be empty" do
      assert_invalid :comment, MESSAGES[:comment_empty], nil, ""
      assert_valid :comment, "valid comment"
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    test "2.1 should belong to one reviewer" do
      user = build :user
      review = build :review, reviewer: user

      assert_same user, review.reviewer
    end



    test "2.2 should belong to one application" do
      application = build :application
      review = build :review, application: application

      assert_same application, review.application
    end

  end

end
