require 'test_helper'

=begin

1 Organizing a conference
  1.1 should create a new conference
  1.2 should set the issuer as the creator

2 Adding an organizer
  2.1 should add the user to the organizers
  2.2 should not add the user if they are already an organizer

3 Removing an organizer
  3.1 should remove the user from the organizers
  3.2 should not remove the user if they are not an organizer

=end

class ConferenceManagerTest < ActiveSupport::TestCase

  def setup
    @manager    ||= Managers::ConferenceManager.new FactoryGirl
    @creator    ||= build :user
    @user1        = build :user
    @user2        = build :user
    @conference   = @manager.create_conference @creator, organizers: [@user2]
  end



  test "1.1 should create a new conference" do
    assert_includes Conference.all, @conference
  end



  test "1.2 should set the issuer as the creator" do
    assert_same @creator, @conference.creator
    assert_includes @creator.created_conferences, @conference
  end



  test "2.1 should add the user to the organizers" do
    @manager.add_organizers @conference, @user1

    assert_includes @conference.organizers, @user1
    assert_includes @user1.organized_conferences, @conference
  end



  test "2.2 should not add the user if they are already an organizer" do
    assert_equal 1, @conference.organizers.count

    @manager.add_organizers @conference, @user2

    assert_equal 1, @conference.organizers.count
  end



  test "3.1 should remove the user from the organizers" do
    @manager.remove_organizers @conference, @user2

    assert_not_includes @conference.organizers, @user2
    assert_not_includes @user2.organized_conferences, @conference
  end



  test "3.2 should not remove the user if they are not an organizer" do
    assert_equal 1, @conference.organizers.count

    @manager.remove_organizers @conference, @user1

    assert_equal 1, @conference.organizers.count
  end

end
