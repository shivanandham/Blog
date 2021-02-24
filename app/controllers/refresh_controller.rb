class RefreshController < ApplicationController
  before_action :authorize_refresh_by_access_request!

  def create
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_action_allowed: true)
    
    
    tokens = session.refresh_by_action_allowed do
      raise JWTSessions::Errors::Unauthorized, "Not supposed to be here"
    end
    
    
    response.set_cookie(JWTSessions.access_cookie,
    value: tokens[:access],
    httponly: true,
    secure: Rails.env.production?)

    render json: {cstf: tokens[:csrf]}
  end
end
