require 'active_support/concern'

module ParamsChecking

  extend ActiveSupport::Concern

  included do

    def user_data
      params.fetch(:userdata, {}).permit :name, :email, :login, :password
    end

  end

end
