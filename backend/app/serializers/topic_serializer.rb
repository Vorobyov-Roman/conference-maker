class TopicSerializer < ActiveModel::Serializer

  attributes :id, :title, :description

  has_one  :conference
  has_many :moderators
  has_many :applications

end
