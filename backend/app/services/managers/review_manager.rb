class Managers::ReviewManager

  def initialize factory
    @factory = factory
  end

  def create_review issuer, application, params
    @factory.create :review, params.merge(
      reviewer: issuer,
      application: application
    )
  end

end
