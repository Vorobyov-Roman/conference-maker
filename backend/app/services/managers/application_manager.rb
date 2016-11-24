class Managers::ApplicationManager

  def initialize factory
    @factory = factory
  end

  def create_application issuer, topic, params
    @factory.create :application, params.merge(sender: issuer, topic: topic)
  end

end
