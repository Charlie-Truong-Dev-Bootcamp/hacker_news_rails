class VotesController < ApplicationController
  def create
    # don't create this temp local variable
    user = current_user
    Vote.create(user_id: user.id, post_id: params[:post_id])
    redirect_to :back
  end
end
