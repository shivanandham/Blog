module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!

      def show
        @user = User.find(params[:id])
        render json: @user
      end
    end
  end
end