module Associations::ConferenceTopics

  def self.association_for_topic target
    target.belongs_to :conference
  end

  def self.association_for_conference target
    target.has_many :topics
  end
  
end
