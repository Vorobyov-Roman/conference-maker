module Associations::ApplicationsTopic

  def self.association_for_application target
    target.belongs_to :topic, inverse_of: :applications
  end

  def self.association_for_topic target
    target.has_many :applications, inverse_of: :topic
  end

end
