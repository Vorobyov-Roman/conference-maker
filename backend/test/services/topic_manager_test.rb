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

  def reset_current_manager user
    @current_user = user
    @manager = TopicManager.new
  end

  def setup
    reset_current_manager users(:fourth)
  end

  def teardown
    Topic.delete_all
    Rails.cache.clear
  end



  test "1.1 should create a new topic" do
    params = { title: "title", description: "description" }
    topic = @manager.create_topic conferences(:second), params

    assert_includes Topic.all, topic
  end



  test "1.2 should set the conference as the topic's conference" do
    params = { title: "title", description: "description" }
    topic = @manager.create_topic conferences(:second), params

    assert_equal topic.conference, conferences(:second)
    assert_includes conferences(:second).topics, topic
  end



  test "2.1 should add the user to the moderators" do
    topic = topics(:third)
    user = users(:second)

    @manager.add_moderators topic, user

    assert_includes user.moderated_topics, topic
    assert_includes topic.moderators, user
  end



  test "2.2 should not add the user if they are already a moderator" do
    topic = topics(:third)
    user = users(:third)

    before_count = topic.moderators.count

    @manager.add_moderators topic, user

    assert_equal topic.moderators.count, before_count
  end



  test "3.1 should remove the user from the moderators" do
    topic = topics(:third)
    user = users(:third)

    @manager.remove_moderators topic, user

    assert_not_includes user.moderated_topics, topic
    assert_not_includes topic.moderators, user
  end



  test "3.2 should not remove the user if they are not a moderator" do
    topic = topics(:third)
    user = users(:second)

    before_count = topic.moderators.count

    @manager.remove_moderators topic, user

    assert_equal topic.moderators.count, before_count
  end

end
