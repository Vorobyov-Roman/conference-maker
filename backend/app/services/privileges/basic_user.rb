module Privileges

  class BasicUser

    def initialize user
      @user = user
    end

    def create_conference params
      conference_manager.create_conference @user, params
    end

  private

    def conference_manager
      ConferenceManager.new
    end

  end

end
