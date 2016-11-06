module UserPrivileges::ConferenceOrganizer

  def as_organizer conference
    @as_organizer ||= Privileges::ConferenceOrganizer.new self, conference
  end

  def create_topic conference, params
    as_organizer(conference).create_topic conference, params
  end

  def assign_moderators topic, *users
    as_organizer(topic.conference).add_moderators topic, *users
  end

  def assign_moderators topic, *users
    as_organizer(topic.conference).remove_moderators topic, *users
  end

end
