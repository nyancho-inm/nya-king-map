class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/cats/#{@comment.cat.id}" 
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to "/cats/#{@comment.cat.id}" 
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, cat_id: params[:cat_id])
  end
end
