require 'active_support/concern'

module Associations

  extend ActiveSupport::Concern

  included do
    Associations.declare_associations_for self
  end

  def self.declare_associations_for target
    get_association self, target
  end

private

  def self.get_association source, target
    source.send :"association_for_#{target.name.underscore}", target
  end

  def self.association_for_user target
    get_association ConferencesOrganizers, target
    get_association TopicsModerators, target
  end

  def self.association_for_conference target
    get_association ConferencesOrganizers, target
    get_association ConferenceTopics, target
  end

  def self.association_for_topic target
    get_association ConferenceTopics, target
    get_association TopicsModerators, target
  end
  
end
