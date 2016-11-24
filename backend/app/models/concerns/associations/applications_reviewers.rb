module Associations::ApplicationsReviewers

  def self.association_for_application target
    target.has_many :reviewers, through: :reviews
  end

  def self.association_for_user target
    params = {
      through:     :reviews,
      source:      :application
    }

    target.has_many :reviewed_applications, params
  end

end
