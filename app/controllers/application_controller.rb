class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authorize_request

  attr_reader :current_user

  protected

  def map_errors(errors)
    Instrumentation::MapCommandErrors.new(errors: errors).map_errors
  end

  private

  def record_not_found(exception)
    render(json: { errors: ["#{exception.model} not found."] }, status: :not_found)
  end

  def authorize_request
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    begin
      decoded_token = Security::JsonWebToken.decode(token: token)
      @current_user = User.find(decoded_token[:payload][:current_user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ['Could not authenticate user.'] }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { errors: ['Invalid token.'] }, status: :unauthorized
    rescue JWT::ExpiredSignature
      render json: { errors: ['Expired token.'] }, status: :unauthorized
    end
  end
end
