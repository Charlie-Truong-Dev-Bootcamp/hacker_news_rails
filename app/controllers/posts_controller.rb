class PostsController < ApplicationController
  before_filter :determine_scope, :except => [:create, :new]

  def index
    @posts = @scope.all
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
