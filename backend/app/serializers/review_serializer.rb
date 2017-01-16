class ReviewSerializer < ActiveModel::Serializer

  attributes :id, :status, :comment

  has_one :reviewer
  has_one :application

end
