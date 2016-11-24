require 'test_helper'

=begin

1 Creating a review
  1.1 should create a new review
  1.2 should set the issuer as the reviewer
  1.3 should set the review's application

=end

class ReviewManagerTest < ActiveSupport::TestCase

  def get_manager
    fake_manager = ReviewManager.new

    def fake_manager.create_review params = {}
      FactoryGirl.create :review, params
    end

    fake_manager
  end

  def manager
    @manager ||= get_manager
  end



  test "1.1 should create a new review" do
    review = manager.create_review
    assert_includes Review.all, review
  end



  test "1.2 should set the issuer as the reviewer" do
    user = build :user
    review = manager.create_review reviewer: user

    assert_same user, review.reviewer
  end



  test "1.3 should set the review's application" do
    application = build :application
    review = manager.create_review application: application

    assert_same application, review.application
  end

end
