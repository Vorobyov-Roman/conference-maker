module Associations::ConferencesCreator

  def self.association_for_user target
    params = {
      class_name:  "Conference",
      foreign_key: "creator_id",
      inverse_of:  :creator
    }

    target.has_many :created_conferences, params
  end

  def self.association_for_conference target
    params = {
      class_name: "User",
      inverse_of: :created_conferences
    }

    target.belongs_to :creator, params
  end

end
