class ApplicationSerializer < ActiveModel::Serializer

  attributes :id, :title, :description

  has_one :sender
  has_one :topic
  has_one :next_version
  has_one :previous_version
  has_many :reviews
  has_many :reviewers

end

