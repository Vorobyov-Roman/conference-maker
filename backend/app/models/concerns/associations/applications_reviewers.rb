module Associations::ApplicationsReviewers

  def self.association_for_application target
    params = {
      through:    :reviews,
      class_name: "User"
    }

    target.has_many :reviewers, params
  end

  def self.association_for_user target
    params = {
      through:     :reviews,
      source:      :application,
      foreign_key: "reviewer_id"
    }

    target.has_many :reviewed_applications, params
  end
  
end
