module Associations::ConferencesOrganizers

  def self.association_for target
    self.send :"association_for_#{target.name.underscore}", target
  end

private

  def self.association_for_user target
    params = {
      class_name:  "Conference",
      foreign_key: "organizer_id",
      join_table:  "conferences_organizers"
    }

    target.has_and_belongs_to_many :organized_conferences, params
  end

  def self.association_for_conference target
    params = {
      class_name:              "User",
      association_foreign_key: "organizer_id",
      join_table:              "conferences_organizers"
    }

    target.has_and_belongs_to_many :organizers, params
  end
  
end
