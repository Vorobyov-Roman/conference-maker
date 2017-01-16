class ApplicationsController < ApplicationController

  include ParamsChecking

  def index
    applications = Application.all

    render json: applications
  end

  def show
    application = Application.find_by_id params[:id]

    render application.nil? ? { status: :not_found } : { json: application }
  end

end
