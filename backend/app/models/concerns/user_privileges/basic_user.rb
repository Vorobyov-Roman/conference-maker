module UserPrivileges::BasicUser

  def as_basic_user
    basic_user_wrapper.new managers_provider, self
  end

  def create_conference params
    as_basic_user.create_conference params
  end

  def send_application topic, params
    as_basic_user.send_application topic, params
  end

private

  def basic_user_wrapper
    Privileges::BasicUser
  end

end
