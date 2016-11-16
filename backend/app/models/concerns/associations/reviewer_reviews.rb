module Associations::ReviewerReviews

  def self.association_for_user target
    target.has_many :reviews
  end

  def self.association_for_review target
    target.references :reviewer, class_name: "User"
  end
  
end
