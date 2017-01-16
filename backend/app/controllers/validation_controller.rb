class ValidationController < ApplicationController

  include ParamsChecking

  def application
    check :application, application_data
  end

  def conference
    check :conference, conference_data
  end

  def review
    check :review, review_data
  end

  def topic
    check :topic, topic_data
  end

  def user
    check :user, user_data
  end

private

  def check model, data
    messages = validator.check model, data

    messages = messages[field] if field

    render json: { errors: messages }
  end

  def field
    params[:field] && params[:field].to_sym
  end

end
