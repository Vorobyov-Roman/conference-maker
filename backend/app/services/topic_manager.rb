class TopicManager

  def initialize issuer
    @issuer = issuer
  end

  def create_topic conference, params
    check_issuer_has_permissions conference.organizers

    Topic.create(params.merge conference: conference)
  end

  def add_moderators topic, *users
    check_issuer_has_permissions topic.conference.organizers

    users.each do |user|
      topic.moderators << user unless topic.moderators.include? user
    end
  end

  def remove_moderators topic, *users
    check_issuer_has_permissions topic.conference.organizers

    users.each { |user| topic.moderators.delete user }
  end


private

  def check_issuer_has_permissions organizers
    organizers.each { |organizer| return if organizer == @issuer }

    raise InsufficientPermissions.new
  end

end
