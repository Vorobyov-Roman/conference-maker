class Privileges::ConferenceOrganizer < Privileges::BasicUser

  def initialize managers_provider, user, conference
    super managers_provider, user
    @conference = conference

    check_is_organizer @conference
  end

  def create_topic conference, params
    topic_manager.create_topic conference, params
  end

  def assign_moderators topic, *users
    topic_manager.add_moderators topic, *users
  end

  def remove_moderators topic, *users
    topic_manager.remove_moderators topic, *users
  end

end
