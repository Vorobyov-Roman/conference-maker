module Associations::ApplicationsConferences

  def self.association_for_application target
    target.references :conference, through: :topic
  end

  def self.association_for_conference target
    target.has_many :applications, through: :topics
  end
  
end
