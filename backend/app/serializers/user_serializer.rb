class UserSerializer < ActiveModel::Serializer

  attributes :id, :name, :email

  has_many :created_conferences
  has_many :organized_conferences
  has_many :moderated_topics
  has_many :sent_applications
  has_many :reviews
  has_many :reviewed_applications
  has_many :attended_conferences

end
