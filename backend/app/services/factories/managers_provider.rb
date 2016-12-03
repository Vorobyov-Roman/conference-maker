class Factories::ManagersProvider

  def initialize factory
    @factory = factory
  end

  def provide name
    manager(name).new @factory
  end

private

  MANAGERS = {
    application: Managers::ApplicationManager,
    conference:  Managers::ConferenceManager,
    review:      Managers::ReviewManager,
    topic:       Managers::TopicManager
  }

  def manager name
    MANAGERS[name]
  end

end
