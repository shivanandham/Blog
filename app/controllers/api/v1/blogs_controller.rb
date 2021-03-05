module Api
  module V1
    class BlogsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_blog, only: [:show, :update, :destroy]

      # GET /blogs
      def index
        @blogs = current_user.blogs.all

        render json: @blogs
      end

      # GET /blogs/1
      def show
        render json: @blog
      end

      # POST /blogs
      def create
        @blog = current_user.blogs.build(blog_params)

        if @blog.save
          render json: @blog, status: :created
        else
          render json: @blog.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /blogs/1
      def update
        if @blog.update(blog_params)
          render json: @blog
        else
          render json: @blog.errors, status: :unprocessable_entity
        end
      end

      # DELETE /blogs/1
      def destroy
        @blog.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_blog
          @blog = current_user.blogs.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def blog_params
          params.require(:blog).permit(:title, :body, :user_id)
        end
    end
  end
end