class Managers::TopicManager

  def initialize factory
    @factory = factory
  end

  def create_topic conference, params
    @factory.create :topic, params.merge(conference: conference)
  end

  def add_moderators topic, *users
    users.each do |user|
      topic.moderators << user unless topic.moderators.include? user
    end
  end

  def remove_moderators topic, *users
    users.each { |user| topic.moderators.delete user }
  end

end
