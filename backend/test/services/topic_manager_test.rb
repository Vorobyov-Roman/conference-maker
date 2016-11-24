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

  def setup
    @manager    ||= Managers::TopicManager.new FactoryGirl
    @conference ||= build :conference
    @user1        = build :user
    @user2        = build :user
    @topic        = @manager.create_topic @conference, moderators: [@user2]
  end



  test "1.1 should create a new topic" do
    assert_includes Topic.all, @topic
  end



  test "1.2 should set the conference as the topic's conference" do
    assert_equal @topic.conference, @conference
    assert_includes @conference.topics, @topic
  end



  test "2.1 should add the user to the moderators" do
    @manager.add_moderators @topic, @user1

    assert_includes @user1.moderated_topics, @topic
    assert_includes @topic.moderators, @user1
  end



  test "2.2 should not add the user if they are already a moderator" do
    assert_equal 1, @topic.moderators.count

    @manager.add_moderators @topic, @user2

    assert_equal 1, @topic.moderators.count
  end



  test "3.1 should remove the user from the moderators" do
    @manager.remove_moderators @topic, @user2

    assert_not_includes @user2.moderated_topics, @topic
    assert_not_includes @topic.moderators, @user2
  end



  test "3.2 should not remove the user if they are not a moderator" do
    assert_equal 1, @topic.moderators.count

    @manager.remove_moderators @topic, @user1

    assert_equal 1, @topic.moderators.count
  end

end
