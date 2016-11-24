class ApplicationManager

  def create_application issuer, topic, params
    Application.create(params.merge sender: issuer, topic: topic)
  end

end
