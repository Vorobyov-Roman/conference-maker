require 'test_helper'

=begin

1 Creating an application
  1.1 should create a new appliaction
  1.2 should set the issuer as the application's sender
  1.3 should set the application's topic

2 Updating an application
  2.1 should create a new application
  2.2 should set the issuer as the application's sender
  2.3 should set the previous version
  2.4 should set the application's topic to the one of its parent

=end

class ApplicationManagerTest < ActiveSupport::TestCase

  def setup
    @manager     ||= Managers::ApplicationManager.new FactoryGirl
    @user        ||= build :user
    @topic       ||= build :topic
    @application ||= @manager.create_application @user, @topic, {}
    @updated     ||= @manager.update_application @user, @application, {}
  end



  test "1.1 should create a new topic" do
    assert_includes Application.all, @application
  end



  test "1.2 should set the issuer as the application's sender" do
    assert_same @user, @application.sender
    assert_includes @user.sent_applications, @application
  end



  test "1.3 should set the application's topic" do
    assert_same @topic, @application.topic
    assert_includes @topic.applications, @application
  end



  test "2.1 should create a new application" do
    assert_includes Application.all, @updated
  end



  test "2.2 should set the issuer as the application's sender" do
    assert_same @user, @updated.sender
    assert_includes @user.sent_applications, @updated
  end



  test "2.3 should set the previous version" do
    assert_same @updated, @application.next_version
    assert_same @application, @updated.previous_version
  end



  test "2.4 should set the application's topic to the one of its parent" do
    assert_same @topic, @updated.topic
    assert_includes @topic.applications, @updated
  end

end
