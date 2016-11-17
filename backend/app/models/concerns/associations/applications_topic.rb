module Associations::ApplicationsTopic

  def self.association_for_application target
    target.references :topic
  end

  def self.association_for_topic target
    target.has_many :applications
  end
  
end
