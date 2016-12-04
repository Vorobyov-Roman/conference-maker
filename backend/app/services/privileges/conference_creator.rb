class Privileges::ConferenceCreator < Privileges::BasicUser

  def initialize managers_provider, user, conference
    super managers_provider, user
    @conference = conference

    check_is_creator_of @conference
  end

  def assign_organizers *users
    conference_manager.add_organizers @conference, *users
  end

  def remove_organizer *users
    conference_manager.remove_organizers @conference, *users
  end

end
