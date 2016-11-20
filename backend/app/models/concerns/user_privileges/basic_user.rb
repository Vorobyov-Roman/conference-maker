module UserPrivileges::BasicUser

  def as_basic_user
    @as_basic_user ||= basic_user_wrapper.new self
  end

  def create_conference params
    as_basic_user.create_conference params
  end

private

  def basic_user_wrapper
    Privileges::BasicUser
  end

end
