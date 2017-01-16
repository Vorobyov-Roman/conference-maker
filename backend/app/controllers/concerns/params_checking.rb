require 'active_support/concern'

module ParamsChecking

  extend ActiveSupport::Concern

  included do

    def application_data
      params.fetch(:data, {}).permit :title, :description
    end

    def conference_data
      params.fetch(:data, {}).permit :title, :description
    end

    def review_data
      params.fetch(:data, {}).permit :status, :comment
    end

    def topic_data
      params.fetch(:data, {}).permit :title, :description
    end

    def user_data
      params.fetch(:data, {}).permit :name, :email, :login, :password
    end

  end

end
