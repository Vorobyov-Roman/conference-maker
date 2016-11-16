module Associations::ApplicationReviews

  def self.association_for_application target
    target.has_many :reviews
  end

  def self.association_for_review target
    target.references :application
  end
  
end
