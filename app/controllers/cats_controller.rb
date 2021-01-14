class CatsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def create
    Cat.create(cat_params)
  end

  private

  def cat_params
    params.require(:cat).permit(:message, :prefecture_id, :area, :place, :image).merge(user_id: current_user.id)
  end
end
