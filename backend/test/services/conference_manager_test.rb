require 'test_helper'

=begin

1 Organizing a conference
  1.1 should create a new conference
  1.2 should set the issuer as the creator

2 Adding an organizer
  2.1 should check if the issuer is the creator
  2.2 should add the user to the organizers
  2.3 should not add the user if they are already an organizer

3 Removing an organizer
  3.1 should check if the issuer is the creator
  3.2 should remove the user from the organizers
  3.3 should not remove the user if they are not an organizer

=end

class ConferenceManagerTest < ActiveSupport::TestCase

  def reset_current_manager user
    @current_user = user
    @manager = ConferenceManager.new @current_user
  end

  def setup
    reset_current_manager users(:first)
  end

  def teardown
    Conference.delete_all
    Rails.cache.clear
  end



  test "1.1 should create a new conference" do
    params = { title: "title", description: "description" }
    conference = @manager.create_conference params

    assert_includes Conference.all, conference
  end



  test "1.2 should set the issuer as the creator" do
    params = { title: "title", description: "description" }
    conference = @manager.create_conference params

    assert_equal conference.creator, @current_user
  end



  test "2.1 should check if the issuer is the creator" do
    assert_raises InsufficientPermissions do
      @manager.add_organizers conferences(:third), users(:fifth)
    end

    assert_nothing_raised do
      @manager.add_organizers conferences(:first), users(:fifth)
    end
  end



  test "2.2 should add the user to the organizers" do
    conference = conferences(:first)
    user = users(:fifth)
    
    @manager.add_organizers conference, user

    assert_includes conference.organizers, user
    assert_includes user.organized_conferences, conference
  end



  test "2.3 should not add the user if they are already an organizer" do
    conference = conferences(:first)
    user = users(:second)

    before_count = conference.organizers.count
    
    @manager.add_organizers conference, user

    assert_equal conference.organizers.count, before_count
  end



  test "3.1 should check if the issuer is the creator" do
    assert_raises InsufficientPermissions do
      @manager.remove_organizers conferences(:third), users(:second)
    end

    assert_nothing_raised do
      @manager.remove_organizers conferences(:first), users(:second)
    end
  end



  test "3.2 should remove the user from the organizers" do
    conference = conferences(:first)
    user = users(:second)

    @manager.remove_organizers conference, user

    assert_not_includes conference.organizers, user
    assert_not_includes user.organized_conferences, conference
  end



  test "3.3 should not remove the user if they are not an organizer" do
    conference = conferences(:first)
    user = users(:fourth)

    before_count = conference.organizers.count

    @manager.remove_organizers conference, user

    assert_equal conference.organizers.count, before_count
  end

end
