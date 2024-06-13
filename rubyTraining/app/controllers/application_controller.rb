class ApplicationController < ActionController::Base
  def authenticate_request!
    if current_user.nil?
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  def current_user
    return nil unless request.headers['Authorization']

    token = request.headers['Authorization'].split(' ').last
    decoded_token = JWT.decode(token, Rails.application.secret_key_base)[0]
    User.find(decoded_token['user_id'])
  rescue JWT::DecodeError
    nil
  end
end
