require 'test_helper'

=begin

1 Organizing a conference
  1.1 should create a new conference
  1.2 should set the issuer as the creator

2 Adding an organizer
  2.1 should check if the issuer is the creator
  2.2 should add the user to the organizers

3 Removing an organizer
  3.1 should check if the issuer is the creator
  3.2 should remove the user from the organizers

=end

class ConferenceManagerTest < ActiveSupport::TestCase

  def reset_current_user user
    @current_user = user
  end

  def reset_current_manager
    @manager = ConferenceManager.new @current_user
  end

  def setup
    reset_current_user users(:illuminati)
    reset_current_manager
  end

  def teardown
    Conference.delete_all
    Rails.cache.clear
  end



  test "1.1: should create a new conference" do
  end



  test "1.2: should set the issuer as the creator" do
  end



  test "2.1: should check if the issuer is the creator" do
  end



  test "2.2: should add the user to the organizers" do
  end



  test "3.1: should check if the issuer is the creator" do
  end



  test "3.2: should remove the user from the organizers" do
  end

end
