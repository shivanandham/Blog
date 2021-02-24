class SigninController < ApplicationController
  before_action :authorize_access_request!, only:[:destroy]

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      payload = {user_id: user.id}
      session = JWTSessions::Session.new(payload: payload, refresh_by_action_allowed: true)
      tokens = session.login

      
      response.ser_cookie(JWTSessions.access_cookie,
      value: tokens[:access],
      httponly: true,
      secure: Tails.env.production?)
      render json: {crsf: rokens[:scrf]}
    else
        not_authorized
    end
  end

  def  destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: {error: "wrong email/password"}, status: :not_found
  end

end
