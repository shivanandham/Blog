module Api
  module V2
    class BlogsController < ApplicationController
      before_action :authorize_access_request!
      # before_action :set_blog, only: [:show, :update, :destroy]

      # GET /blogs
      def index
        @blogs = Blog.all

        render json: @blogs
      end

      def getChart
        groupByData = Blog.joins(:user).group(:name).count('id')

        array=[]
        groupByData.each do |key,value|
    
          a=[key.to_s,value]
       
         array.push(a)
    
        end
          render json: array 
      end

      # GET /blogs/1
      def show
        @blog = Blog.find(params[:id])
        render json: @blog
      end

      # POST /blogs
      def new
        @blog = current_user.blogs.build(blog_params)
      end

      def create
        @blog = current_user.blogs.build(blog_params)

        if @blog.save
        render json: { status: :ok, message: 'Success' }
        else
          render json: { json: @blog.errors, status: :unprocessable_entity }
        end

      end

      # PATCH/PUT /blogs/1
      def edit
        @blog = Blog.find(params[:id])
        render json: @blog
      end

      def update
        @blog = Blog.find(params[:id])

        if @blog.update(blog_params)
          render json: @blog
        else
          render json: @blog.errors, status: :unprocessable_entity
        end
      end

      # DELETE /blogs/1
      def destroy
        @blog = Blog.find(params[:id])
        @blog.destroy
        render json: @blog
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_blog
          @blog = current_user.blogs.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def blog_params
          params.require(:blog).permit(:title, :body)
        end
    end
  end
end