require 'test_helper'

=begin

1 Creating an application
  1.1 should create a new appliaction
  1.2 should set the issuer as the application's sender
  1.3 should set the application's topic

=end

class ApplicationManagerTest < ActiveSupport::TestCase

  def get_manager
    fake_manager = ApplicationManager.new

    def fake_manager.create_application params = {}
      FactoryGirl.create :application, params
    end

    fake_manager
  end

  def manager
    @manager ||= get_manager
  end



  test "1.1 should create a new topic" do
    application = manager.create_application
    assert_includes Application.all, application
  end



  test "1.2 should set the issuer as the application's sender" do
    user = build :user
    application = manager.create_application sender: user

    assert_same user, application.sender
  end



  test "1.3 should set the application's topic" do
    topic = build :topic
    application = manager.create_application topic: topic

    assert_same topic, application.topic
  end

end
