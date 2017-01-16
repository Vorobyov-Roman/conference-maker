class UsersController < ApplicationController

  include ParamsChecking

  def index
    users = User.all

    render json: users
  end

  def show
    user = User.find_by_id params[:id]

    render user.nil? ? { status: :not_found } : { json: user }
  end

end
