module Privileges

  class ConferenceCreator < BasicUser

    def initialize user, conference
      check_user_is_creator user, conference

      super user
      @conference = conference
    end

    def assign_organizers *users
      conference_manager.add_organizers @conference, *users
    end

    def remove_organizer *users
      conference_manager.remove_organizers @conference, *users
    end

  private

    def check_user_is_creator user, conference
      raise UserIsNotTheCreator.new if conference.creator != user
    end

    def conference_manager
      ConferenceManager.new
    end

  end

end
