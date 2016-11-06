module UserPrivileges::ConferenceCreator

  def as_creator conference
    @as_creator ||= Privileges::ConferenceCreator.new self, conference
  end

  def assign_organizers conference, *users
    as_creator(conference).assign_organizers *users
  end

  def remove_organizers conference, *users
    as_creator(conference).remove_organizers *users
  end

end
