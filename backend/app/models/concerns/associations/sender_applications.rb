module Associations::SenderApplications

  def self.association_for_user target
    params = {
      class_name:  "Application",
      foreign_key: "sender_id",
      inverse_of:  :sender
    }

    target.has_many :sent_applications, params
  end

  def self.association_for_application target
    params = {
      class_name: "User",
      inverse_of: :sent_applications
    }

    target.belongs_to :sender, params
  end
  
end
