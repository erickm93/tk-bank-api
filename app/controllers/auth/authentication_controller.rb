module Auth
  class AuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: [:login]

    def login
      if request_user
        payload = { current_user_id: request_user.id }
        token = Security::JsonWebToken.encode(payload: payload)

        return render(json: { token: token })
      end

      render json: { error: 'Authentication error, check your credentials' }
    end

    private

    def user_params
      params
        .require(:user)
        .permit(:email)
    end

    def request_user
      @request_user ||= User.find_by(email: user_params[:email])
    end
  end
end
