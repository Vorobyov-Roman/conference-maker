module Associations::ApplicationsConferences

  def self.association_for_application target
    target.delegate :conference, to: :topic

    target.after_save do |application|
      application.conference.applications.reset
    end
  end

  def self.association_for_conference target
    target.has_many :applications, through: :topics
  end

end
