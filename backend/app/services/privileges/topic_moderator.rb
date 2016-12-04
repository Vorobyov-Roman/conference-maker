class Privileges::TopicModerator < Privileges::BasicUser

  def initialize managers_provider, user, topic
    super managers_provider, user
    @topic = topic

    check_is_moderator_of @topic
  end

  def review_application application, params
    review_manager.create_review @user, application, params
  end

end
