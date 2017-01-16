class TopicsController < ApplicationController

  include ParamsChecking

  def index
    topics = Topic.all

    render json: topics
  end

  def show
    topic = Topic.find_by_id params[:id]

    render topic.nil? ? { status: :not_found } : { json: topic }
  end

end
