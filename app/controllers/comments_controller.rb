class CommentsController < ApplicationController
  before_filter :determine_scope, :except => [:create]

  def index
    @model = @scope
    @comments = @model.comments
    @comment = Comment.new
  end

  def create
    if session[:user_id].nil?
      flash[:error] = "You need to sign-in or sign-up to comment."
      post = Post.find(params[:post_id])
      redirect_to post_comments_path(post)
    else
      comment = Comment.create(comment_params)
      user = current_user
      post = Post.find(params[:post_id])
      user.comments << comment
      post.comments << comment
      redirect_to post_comments_path(post)
    end
  end

  private

  def determine_scope
    if params[:user_id]
      @scope = User.find(params[:user_id])
    else
      @scope = Post.find(params[:post_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
