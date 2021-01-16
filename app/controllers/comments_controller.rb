class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      ActiveCable.server.broadcast 'comment_channel', {content: @comment, user: @comment.user}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, cat_id: params[:cat_id])
  end
end
