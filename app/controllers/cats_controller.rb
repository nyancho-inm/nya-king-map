class CatsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def index
    
  end

  def new
    @cat = Cat.new
  end

  private

end
