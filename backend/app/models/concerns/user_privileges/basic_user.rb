module UserPrivileges::BasicUser

  def as_basic_user
    @as_basic_user ||= Privileges::BasicUser.new self
  end

  def create_conference params
    as_basic_user.create_conference params
  end

end
