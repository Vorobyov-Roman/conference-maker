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
    topic:       Managers::TopicManager,
    user:        Managers::UserManager
  }

  def manager name
    MANAGERS[name]
  end

end
