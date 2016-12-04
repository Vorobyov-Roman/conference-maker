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
    check_is_not_creator_of topic.conference
    check_is_not_organizer_of topic.conference
    check_is_not_moderator_of topic

    application_manager.create_application @user, topic, params
  end

  def apply_for_attendance conference
    check_is_not_creator_of conference
    check_is_not_organizer_of conference
    check_is_not_moderator_in conference
    check_is_not_sender_in conference, :rejected

    conference_manager.add_attendees conference, @user
  end

end
