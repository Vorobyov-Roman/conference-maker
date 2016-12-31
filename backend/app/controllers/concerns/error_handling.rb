require 'active_support/concern'

module ErrorHandling

  extend ActiveSupport::Concern

  included do

    rescue_from ActionController::RoutingError, with: :routing_error
    rescue_from ActiveRecord::RecordInvalid,    with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound,   with: :record_not_found

    def default
      raise ActionController::RoutingError.new "Incorrect request"
    end

  private

    def routing_error
      render status: :not_found
    end

    def record_invalid e
      render json: { errors: e.record.errors }, status: :bad_request
    end

    def record_not_found e
      render status: :bad_request
    end

  end

end
