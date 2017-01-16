class ConferenceSerializer < ActiveModel::Serializer

  attributes :id, :title, :description

  has_one  :creator
  has_many :organizers
  has_many :topics
  has_many :applications
  has_many :attendees

end
