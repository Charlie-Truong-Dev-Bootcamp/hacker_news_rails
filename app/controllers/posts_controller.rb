class PostsController < ApplicationController
  before_filter :determine_scope, :except => [:create, :new]
  before_filter :sign_in, :only => [:create]

  def index
    @posts = @scope.all
  end

  def sign_in
    if session[:user_id].nil?
      redirect_to :sign_in
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
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
