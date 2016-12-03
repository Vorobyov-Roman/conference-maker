module UserPrivileges::TopicModerator

  def as_moderator topic
    topic_moderator_wrapper.new managers_provider, self, topic
  end

  def review_application application, params
    as_moderator(application.topic).review_application application, params
  end

private

  def topic_moderator_wrapper
    Privileges::TopicModerator
  end

end
