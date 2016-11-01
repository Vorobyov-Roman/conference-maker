class ConferenceManager

  def initialize issuer
    @issuer = issuer
  end

  def create_conference params
    Conference.create(params.merge creator: @issuer)
  end

  def add_organizers conference, *users
    raise InsufficientPermissions.new if conference.creator != @issuer

    users.each do |user|
      conference.organizers << user unless conference.organizers.include? user
    end
  end

  def remove_organizers conference, *users
    raise InsufficientPermissions.new if conference.creator != @issuer

    users.each { |user| conference.organizers.delete user }
  end

end
