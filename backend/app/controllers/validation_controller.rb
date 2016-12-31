class ValidationController < ApplicationController

  include ParamsChecking

  def user
    check :user
  end

private

  def check model
    messages = validator.check :user, user_data

    messages = messages[field] if field

    render json: { errors: messages }
  end

  def field
    params[:field] && params[:field].to_sym
  end

end
