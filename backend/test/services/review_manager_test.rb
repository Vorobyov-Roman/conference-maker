require 'test_helper'

=begin

1 Creating a review
  1.1 should create a new review
  1.2 should set the issuer as the reviewer
  1.3 should set the review's application

=end

class ReviewManagerTest < ActiveSupport::TestCase

  def setup
    @manager     ||= Managers::ReviewManager.new FactoryGirl
    @user        ||= build :user
    @application ||= build :application
    @review      ||= @manager.create_review @user, @application, {}
  end



  test "1.1 should create a new review" do
    assert_includes Review.all, @review
  end



  test "1.2 should set the issuer as the reviewer" do
    assert_same @user, @review.reviewer
    assert_includes @user.reviews, @review
  end



  test "1.3 should set the review's application" do
    assert_same @application, @review.application
    assert_includes @application.reviews, @review
  end

end
