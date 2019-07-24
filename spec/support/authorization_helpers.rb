module AuthorizationHelpers
  def set_jwt_header(user, exp = nil)
    payload = { current_user_id: user.id }
    token = Security::JsonWebToken.encode(encode_args(payload, exp))

    controller.request.headers['Authorization'] = "Bearer #{token}"
  end

  def encode_args(payload, exp)
    return { payload: payload } if exp.blank?

    { payload: payload, exp: exp }
  end
end
