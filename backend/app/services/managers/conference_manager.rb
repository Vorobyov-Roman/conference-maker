class Managers::ConferenceManager

  def initialize factory
    @factory = factory
  end

  def create_conference issuer, params
    @factory.create :conference, params.merge(creator: issuer)
  end

  def add_organizers conference, *users
    users.each do |user|
      conference.organizers << user unless conference.organizers.include? user
    end
  end

  def remove_organizers conference, *users
    users.each { |user| conference.organizers.delete user }
  end

  def add_attendees conference, *users
    users.each do |user|
      conference.attendees << user unless conference.attendees.include? user
    end
  end

  def remove_attendees conference, *users
    users.each { |user| conference.attendees.delete user }
  end

end
