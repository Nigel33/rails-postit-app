class CommentsController < ApplicationController 
	before_action :require_user
	before_action :set_post
	before_action :set_comment, only: [:vote]

	def create 
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.user = current_user

		if @comment.save
			flash['notice'] = "Your comment was added."
			redirect_to post_path(@post)
		else 
			render 'posts/show'
		end 
	end 

	def vote 
		@vote = Vote.create(user: current_user, vote: params[:vote], voteable: @comment)
		
    respond_to do |format|
      format.js do 
        if @vote.valid? 
          flash['notice'] = "Your vote was counted"
        else 
          flash['error'] = "You can only vote for that once"
        end 
      end 
    end 
  end

	private 

	def set_post 
		@post = Post.find_by(slug: params[:post_id])
	end 

	def set_comment
		@comment = Comment.find(params[:id])
	end 
end 