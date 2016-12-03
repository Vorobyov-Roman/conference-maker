module UserPrivileges::ConferenceCreator

  def as_creator conference
    conference_creator_wrapper.new managers_provider, self, conference
  end

  def assign_organizers conference, *users
    as_creator(conference).assign_organizers *users
  end

  def remove_organizers conference, *users
    as_creator(conference).remove_organizers *users
  end

private

  def conference_creator_wrapper
    Privileges::ConferenceCreator
  end

end
