require 'active_support/concern'

module Associations

  extend ActiveSupport::Concern

  included do
    Associations.declare_associations_for self
  end

  def self.declare_associations_for target
    get_association target, self
  end

private

  def self.get_association target, source
    source.send :"association_for_#{target.name.underscore}", target
  end

  def self.association_for_user target
    get_association target, ConferencesCreator
    get_association target, ConferencesOrganizers
    get_association target, TopicsModerators
  end

  def self.association_for_conference target
    get_association target, ConferencesCreator
    get_association target, ConferencesOrganizers
    get_association target, ConferenceTopics
  end

  def self.association_for_topic target
    get_association target, ConferenceTopics
    get_association target, TopicsModerators
  end
  
end
