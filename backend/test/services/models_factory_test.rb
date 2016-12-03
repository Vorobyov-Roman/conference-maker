require 'test_helper'

=begin

1 Basic models creation
  1.1 should create a user
  1.2 should create a conference
  1.3 should create a topic
  1.4 should create an application
  1.5 should create a review

2 Alias resolving
  2.1 should create an applciation by its alisases

=end

class ModelsFactoryTest < ActiveSupport::TestCase

  def params_for_user
    {
      name:     "dummy name",
      email:    "dummy@email",
      login:    "dummy_login",
      password: "dummy_password"
    }
  end

  def params_for_conference
    {
      title:       "dummy title",
      description: "dummy description",
      creator:     @factory.create(:user, params_for_user)
    }
  end

  def params_for_topic
    {
      title:       "dummy title",
      description: "dummy description",
      conference:  @factory.create(:conference, params_for_conference)
    }
  end

  def params_for_application
    {
      title:       "dummy title",
      description: "dummy description",
      sender:      @factory.create(:user, params_for_user),
      topic:       @factory.create(:topic, params_for_topic)
    }
  end

  def params_for_review
    {
      status:      0,
      comment:     "dummy_comment",
      application: @factory.create(:application, params_for_application),
      reviewer:    @factory.create(:user, params_for_user)
    }
  end

  def setup
    @factory ||= Factories::ModelsFactory.new
  end

  def teardown
    User.delete_all
    Conference.delete_all
    Topic.delete_all
    Application.delete_all
    Review.delete_all
  end

  def assert_creates_model factory_name, model_name = factory_name
    params = self.send :"params_for_#{model_name}"
    model = "#{model_name}".classify.constantize
    obj = @factory.create factory_name, params


    assert_includes model.all, obj
  end



  test "1.1 should create a user" do
    assert_creates_model :user
  end



  test "1.2 should create a conference" do
    assert_creates_model :conference
  end



  test "1.3 should create a topic" do
    assert_creates_model :topic
  end



  test "1.4 should create an applciation" do
    assert_creates_model :application
  end



  test "1.5 should create a review" do
    assert_creates_model :review
  end



  test "2.1 should create an applciation by its alisases" do
    assert_creates_model :updated_application,    :application
    assert_creates_model :accepted_application,   :application
    assert_creates_model :rejected_application,   :application
    assert_creates_model :disputable_application, :application
  end

end
