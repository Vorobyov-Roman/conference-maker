class Managers::ApplicationManager

  def initialize factory
    @factory = factory
  end

  def create_application issuer, topic, params
    @factory.create :application, params.merge(
      sender: issuer,
      topic:  topic
    )
  end

  def update_application issuer, parent, params
    @factory.create :updated_application, params.merge(
      sender:           issuer,
      topic:            parent.topic,
      previous_version: parent
    )
  end

end
