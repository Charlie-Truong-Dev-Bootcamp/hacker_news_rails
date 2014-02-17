class CommentsController < ApplicationController
  before_filter :determine_scope :except => [:create]

  def index
    @comments = @scope.all
  end

  def create
    comment = Comment.create(post_params)
    user = current_user
    post = Post.find(params[:post_id])
    user.comments << comment
    post.comments << comment
    redirect_to post_comments(post)
  end

  private

  def determine_scope
    if params[:user_id]
      @scope = User.find(params[:user_id]).comments
    else
      @scope = Post.find(params[:post_id]).comments
    end
  end

  def post_params
    params.require(:comment).permit(:text)
  end
end
