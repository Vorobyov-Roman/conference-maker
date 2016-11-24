module Associations::ApplicationReviews

  def self.association_for_application target
    target.has_many :reviews
  end

  def self.association_for_review target
    target.belongs_to :application
  end

end
