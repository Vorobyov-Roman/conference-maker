require 'test_helper'
require 'validation_test_helper'
require 'association_test_helper'

=begin

1 Validation
  1.1 Comment
    1.1.1 should not be empty unless the status is 'accepted'

2 Associations
  2.1 should reference one reviewer
  2.2 should reference one application

=end

module ReviewTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
    }

    def expect_message message_code
      super MESSAGES[message_code]
    end

    def reset_current_review
      reset_current_record Review do |c|
      end
    end

    def setup
      reset_current_review
    end

    def teardown
      Review.delete_all
      Application.delete_all
      User.delete_all
      Rails.cache.clear
    end



    test "1.1.1 a comment should not be empty unless the status is accepted" do
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    include AssociationTestHelper

    test "2.1 should reference one reviewer" do
    end



    test "2.2 should reference one application" do
    end

  end

end
