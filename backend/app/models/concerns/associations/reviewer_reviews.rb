module Associations::ReviewerReviews

  def self.association_for_user target
    target.has_many :reviews, foreign_key: :reviewer_id
  end

  def self.association_for_review target
    target.belongs_to :reviewer, class_name: "User"
  end

end
