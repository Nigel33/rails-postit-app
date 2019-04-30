class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator, only: [:edit, :update]

  def index
  	@posts = Post.all.sort_by {|post| post.total_votes}.reverse
  end

  def show 
    @comment = Comment.new
  end

  def new 
  	@post = Post.new
  end 

  def edit 
  end 

  def create 
  	@post = Post.new(post_params)
  	@post.user = current_user

  	if @post.save
  		flash['notice'] = 'Post successfully created!'
  		redirect_to posts_path
  	else 
  		render :new
  	end 
  end

  def update 
    if @post.update(post_params) 
      flash['notice'] = "Your Post has been successfully updated"
      redirect_to post_path(@post)
    else 
      render 'edit'
    end 
  end 

  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])

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

  def require_creator 
    access_denied unless logged_in? and (current_user == @post.user || current_user.admin?)
  end 

  def post_params 
  	params.require(:post).permit(:title, :url, :description, category_ids: [])
  end 

  def set_post 
    @post = Post.find_by(slug: params[:id])
  end 

end
