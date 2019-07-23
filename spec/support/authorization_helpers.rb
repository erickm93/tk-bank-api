module AuthorizationHelpers
  def set_jwt_header(user)
    payload = { current_user_id: user.id }
    token = Security::JsonWebToken.encode(payload: payload)

    controller.request.headers['Authorization'] = "Bearer #{token}"
  end
end
