require 'active_support/concern'

module Associations

  extend ActiveSupport::Concern

  included do
    Associations.declare_associations_for self
  end

  def self.declare_associations_for target
    self.send :"association_for_#{target.name.underscore}", target
  end

private

  def self.association_for_user target
    ConferencesOrganizers::association_for target
  end

  def self.association_for_conference target
    ConferencesOrganizers::association_for target
  end
  
end
