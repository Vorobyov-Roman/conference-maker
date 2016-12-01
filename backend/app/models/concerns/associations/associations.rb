require 'active_support/concern'

module Associations

  extend ActiveSupport::Concern

  included do
    Associations.declare_associations_for self
  end

  def self.declare_associations_for target
    get_associations(target).each { |assoc| get_association target, assoc }
  end

private

  def self.get_association target, source
    source.send :"association_for_#{target.name.underscore}", target
  end

  def self.get_associations target
    self.send :"associations_for_#{target.name.underscore}"
  end

  def self.associations_for_user
    [
      ConferencesCreator,       # has many created conferences
      ConferencesOrganizers,    # has many organized conferences
      TopicsModerators,         # has many moderated topics
      SenderApplications,       # has many sent applications
      ReviewerReviews,          # has many reviews
      ApplicationsReviewers     # has many reviewed applications
    ]
  end

  def self.associations_for_conference
    [
      ConferencesCreator,       # belongs to one creator
      ConferencesOrganizers,    # has many organizers
      ConferenceTopics,         # has many topics
      ApplicationsConferences   # has many applications
    ]
  end

  def self.associations_for_topic
    [
      ConferenceTopics,         # belongs to one conference
      TopicsModerators,         # has many moderators
      ApplicationsTopic         # has many applications
    ]
  end

  def self.associations_for_application
    [
      SenderApplications,       # belongs to one sender
      ApplicationsTopic,        # belongs to one topic
      ApplicationsConferences,  # belongs to one conference
      ApplicationReviews,       # has many reviews
      ApplicationsReviewers,    # has many reviewers
      ApplicationVersions       # has many versions
    ]
  end

  def self.associations_for_review
    [
      ReviewerReviews,          # belongs to one reviewer
      ApplicationReviews        # belongs to one application
    ]
  end

end
