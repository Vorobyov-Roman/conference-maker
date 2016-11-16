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
  2.1 should belong to a single sender
  2.2 should have many reviews
  2.3 should have many reviewers

=end

module ApplicationTest

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

    def reset_current_application
      reset_current_record Application do |c|
        c.title =       "valid title"
        c.description = "valid description"

        c.sender = users(:first)
      end
    end

    def setup
      reset_current_application
    end

    def teardown
      Application.delete_all
      Rails.cache.clear
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    include AssociationTestHelper

  end

end
