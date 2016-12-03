module UserPrivileges::ApplicationSender

  def as_sender application
    application_sender_wrapper.new managers_provider, self, application
  end

  def update_application application, *params
    as_sender(application).update_application application, *params
  end

private

  def application_sender_wrapper
    Privileges::ApplicationSender
  end

end
