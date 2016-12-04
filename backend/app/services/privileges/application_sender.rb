class Privileges::ApplicationSender < Privileges::BasicUser

  def initialize managers_provider, user, applciation
    super managers_provider, user
    @applciation = applciation

    check_is_sender_of @applciation
    check_is_not_final @applciation
  end

  def update_application parent, params
    application_manager.update_application @user, parent, params
  end

end
