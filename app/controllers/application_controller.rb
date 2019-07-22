class ApplicationController < ActionController::API
  def not_authorized
    render json: { error: 'not_authorized' }
  end
end
