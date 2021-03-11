module Api
  module V2
    class CommentsController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      # before_action :set_comment, only: [:show, :update, :destroy]

      # GET /comments
      def index
        @blog = Blog.find(params[:blog_id])
        @comments = @blog.comments.all    
        array=[]
        @comments.all.each do |comment|       
         array << { body: comment.body, uname: comment.user.name }    
        end         
    
        render json: array
      end

      # GET /comments/1
      def show        
        @blog = Blog.find(params[:blog_id])

        @comments = @blog.comments.find(params[:id])
          
        render json: @comments
      end

      # POST /comments
      def new
        @comment = Comment.new(comment_params)
      end

      def create
        @comment = current_user.comments.create(comment_params)

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /comments/1
      # def update
      #   if @comment.update(comment_params)
      #     render json: @comment
      #   else
      #     render json: @comment.errors, status: :unprocessable_entity
      #   end
      # end

      # # DELETE /comments/1
      # def destroy
      #   @comment.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_blog
          @comment = current_user.comments.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def comment_params
          params.require(:comment).permit(:body, :blog_id, :user_id)
        end
    end
  end
end
