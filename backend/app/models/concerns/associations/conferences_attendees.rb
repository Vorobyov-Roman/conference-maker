module Associations::ConferencesAttendees

  def self.association_for_user target
    params = {
      class_name:  "Conference",
      foreign_key: :attendee_id,
      join_table:  :attendees_conferences
    }

    target.has_and_belongs_to_many :attended_conferences, params
  end

  def self.association_for_conference target
    params = {
      class_name:              "User",
      association_foreign_key: :attendee_id,
      join_table:              :attendees_conferences
    }

    target.has_and_belongs_to_many :attendees, params
  end

end
