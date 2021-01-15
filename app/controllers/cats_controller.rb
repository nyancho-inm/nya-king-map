class CatsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_path
    else
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:message, :prefecture_id, :area, :place, :image).merge(user_id: current_user.id)
  end
end
