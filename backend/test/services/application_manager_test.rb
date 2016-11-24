require 'test_helper'

=begin

1 Creating an application
  1.1 should create a new appliaction
  1.2 should set the issuer as the application's sender
  1.3 should set the application's topic

=end

class ApplicationManagerTest < ActiveSupport::TestCase

  def setup
    @manager     ||= Managers::ApplicationManager.new FactoryGirl
    @user        ||= build :user
    @topic       ||= build :topic
    @application ||= @manager.create_application @user, @topic, {}
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

end
