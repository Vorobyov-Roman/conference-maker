module Associations::ApplicationVersions

  def self.association_for_application target
    self.association_for_parent target
    self.association_for_child target
  end

private

  def self.association_for_parent target
    target.has_one :next_version, class_name:  "Application",
                                  foreign_key: :parent_id,
                                  inverse_of:  :previous_version
  end

  def self.association_for_child target
    target.belongs_to :previous_version, class_name:  "Application",
                                         foreign_key: :parent_id,
                                         inverse_of:  :next_version,
                                         optional:    true
  end

end
