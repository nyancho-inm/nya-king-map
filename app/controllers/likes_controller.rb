class LikesController < ApplicationController
  
  def create
    Like.create(user_id: current_user.id, cat_id: params[:id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Like.find_by(user_id: current_user.id, cat_id: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

end
