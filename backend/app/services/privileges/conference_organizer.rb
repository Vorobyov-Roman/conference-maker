module Privileges

  class ConferenceOrganizer < BasicUser

    def initialize user, conference
      check_user_is_organizer user, conference

      super user
      @conference = conference
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

  private

    def check_user_is_organizer user, conference
      raise UserIsNotAnOrganizer.new unless conference.organizers.include? user
    end

    def topic_manager
      TopicManager.new
    end

  end
  
end