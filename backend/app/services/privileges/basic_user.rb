class Privileges::BasicUser

  include Privileges::Utils

  def initialize managers_provider, user
    @managers_provider = managers_provider
    @user = user
  end

  def create_conference params
    conference_manager.create_conference @user, params
  end

  def send_application topic, params
    check_is_not_creator topic.conference
    check_is_not_organizer topic.conference
    check_is_not_moderator topic

    application_manager.create_application @user, topic, params
  end

end
