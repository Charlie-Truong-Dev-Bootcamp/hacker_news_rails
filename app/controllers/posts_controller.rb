class PostsController < ApplicationController
  before_filter :determine_scope, :except => [:create, :new]
  # consider a better name. The before_filter doesn't sign you in, it requires you to be signed in...
  # e.g. before_filter :require_login
  before_filter :sign_in, :only => [:create, :new]

  def index
    @posts = @scope.all
  end

  # this can be private
  def sign_in
    if session[:user_id].nil?
      redirect_to :new_session
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      # don't set user as a separate step, it causes a second database call.
      # instead: Post.new(post_params.merge(user: current_user)
      @user = current_user
      @user.posts << @post
      redirect_to :root
    else
      render "new"
    end
  end

  private

  def determine_scope
    if params[:user_id]
      @scope = User.find(params[:user_id]).posts
    else
      @scope = Post
    end
  end

  def post_params
    params.require(:post).permit(:title, :url)
  end
end
