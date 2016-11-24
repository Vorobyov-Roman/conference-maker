class ReviewManager

  def create_review issuer, application, params
    Review.create(params.merge reviewer: issuer, application: application)
  end

end
