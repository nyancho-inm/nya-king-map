class CatsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :set_cat ,only: [:show, :edit, :update, :destroy]
  def index
    @cats = Cat.all.order(created_at: :desc)
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
    @comment = Comment.new
    @comments = @cat.comments.includes(:user)
  end

  def edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_path
    else
      render :edit
    end
  end

  def destroy  
    if @cat.destroy
      redirect_to root_path
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:message, :prefecture_id, :area, :place, images: []).merge(user_id: current_user.id)
  end

  def set_cat
    @cat = Cat.find(params[:id])
  end
end
