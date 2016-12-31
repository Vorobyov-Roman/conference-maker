class AuthController < ApplicationController

  include ParamsChecking

  def register
    user = user_manager.create_user user_data

    render json: serializer.to_json(user), status: :created
  end

  def login
    user = user_manager.find_by_login user_data[:login]
    raise ActiveRecord::RecordNotFound if user_data[:password] != user.password

    render json: { token: jwt_wrapper.encode(user) }
  end

private

  def user_manager
    managers_provider.provide :user
  end

end
