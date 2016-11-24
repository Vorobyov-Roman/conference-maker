module Associations::ConferenceTopics

  def self.association_for_topic target
    target.belongs_to :conference, inverse_of: :topics
  end

  def self.association_for_conference target
    target.has_many :topics, inverse_of: :conference
  end

end
