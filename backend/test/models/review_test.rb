require 'test_helper'
require 'validation_test_helper'

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



    test "1.1.1 a comment should not be empty unless the status is accepted" do
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    test "2.1 should reference one reviewer" do
    end



    test "2.2 should reference one application" do
    end

  end

end
