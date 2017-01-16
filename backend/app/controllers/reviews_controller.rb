class ReviewsController < ApplicationController

  include ParamsChecking

  def index
    reviews = Review.all

    render json: reviews
  end

  def show
    review = Review.find_by_id params[:id]

    render reviews.nil? ? { status: :not_found } : { json: reviews }
  end

end
