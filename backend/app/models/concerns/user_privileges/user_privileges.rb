require 'active_support/concern'

module UserPrivileges

  extend ActiveSupport::Concern

  included do
    include UserPrivileges::BasicUser
    include UserPrivileges::ConferenceCreator
    include UserPrivileges::ConferenceOrganizer
    include UserPrivileges::TopicModerator
    include UserPrivileges::ApplicationSender
  end

end
