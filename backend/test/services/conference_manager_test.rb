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

  def get_manager
    fake_manager = ConferenceManager.new

    def fake_manager.create_conference params = {}
      FactoryGirl.create :conference, params
    end

    fake_manager
  end

  def manager
    @manager ||= get_manager
  end



  test "1.1 should create a new conference" do
    conference = manager.create_conference
    assert conference
  end



  test "1.2 should set the issuer as the creator" do
    user = create :user
    conference = manager.create_conference creator: user

    assert_equal conference.creator, user
    assert_includes user.created_conferences, conference
  end



  test "2.1 should add the user to the organizers" do
    conference = create :conference
    user = create :user

    manager.add_organizers conference, user

    assert_includes conference.organizers, user
    assert_includes user.organized_conferences, conference
  end



  test "2.2 should not add the user if they are already an organizer" do
    user = create :user
    conference = create :conference, organizers: [user]

    before_count = conference.organizers.count

    manager.add_organizers conference, user

    assert_equal conference.organizers.count, before_count
  end



  test "3.1 should remove the user from the organizers" do
    user = create :user
    conference = create :conference, organizers: [user]

    manager.remove_organizers conference, user

    assert_not_includes conference.organizers, user
    assert_not_includes user.organized_conferences, conference
  end



  test "3.2 should not remove the user if they are not an organizer" do
    conference = create :conference
    user = create :user

    before_count = conference.organizers.count

    manager.remove_organizers conference, user

    assert_equal conference.organizers.count, before_count
  end

end
