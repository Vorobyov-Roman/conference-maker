class ConferencesController < ApplicationController

  include ParamsChecking

  def index
    conferences = Conference.all

    render json: conferences
  end

  def show
    conference = Conference.find_by_id params[:id]

    render conference.nil? ? { status: :not_found } : { json: conference }
  end

  def create
    return render(status: :unauthorized) if token.nil?

    userinfo = jwt_wrapper.decode token
    user = User.find_by_id userinfo["id"]

    conference = conference_manager.create_conference user, conference_data

    render json: conference, status: :created
  end

private

  def token
    @token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def conference_manager
    managers_provider.provide :conference
  end

end
