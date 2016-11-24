class Managers::ReviewManager

  def initialize factory
    @factory = factory
  end

  def create_review issuer, application, params
    params.merge! reviewer: issuer, application: application

    @factory.create :review, params
  end

end
