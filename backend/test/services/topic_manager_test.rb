require 'test_helper'

=begin

1 Creating a topic
  1.1 should create a new topic
  1.2 should set the conference as the topic's conference

2 Adding a moderator
  2.1 should add the user to the moderators
  2.2 should not add the user if they are already a moderator

3 Removing a moderator
  3.1 should remove the user from the moderators
  3.2 should not remove the user if they are not a moderator

=end

class TopicManagerTest < ActiveSupport::TestCase

  def get_manager
    fake_manager = TopicManager.new

    def fake_manager.create_topic params = {}
      FactoryGirl.create :topic, params
    end

    fake_manager
  end

  def manager
    @manager ||= get_manager
  end



  test "1.1 should create a new topic" do
    topic = manager.create_topic
    assert_includes Topic.all, topic
  end



  test "1.2 should set the conference as the topic's conference" do
    conference = create :conference
    topic = manager.create_topic conference: conference

    assert_equal topic.conference, conference
    assert_includes conference.topics, topic
  end



  test "2.1 should add the user to the moderators" do
    topic = create :topic
    user = create :user

    manager.add_moderators topic, user

    assert_includes user.moderated_topics, topic
    assert_includes topic.moderators, user
  end



  test "2.2 should not add the user if they are already a moderator" do
    user = create :user
    topic = create :topic, moderators: [user]

    before_count = topic.moderators.count

    manager.add_moderators topic, user

    assert_equal topic.moderators.count, before_count
  end



  test "3.1 should remove the user from the moderators" do
    user = create :user
    topic = create :topic, moderators: [user]

    manager.remove_moderators topic, user

    assert_not_includes user.moderated_topics, topic
    assert_not_includes topic.moderators, user
  end



  test "3.2 should not remove the user if they are not a moderator" do
    topic = create :topic
    user = create :user

    before_count = topic.moderators.count

    manager.remove_moderators topic, user

    assert_equal topic.moderators.count, before_count
  end

end
