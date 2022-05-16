class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [ :new]

  def index
    @prototype = Prototype.includes(:user).order("created_at DESC")
  end
  
  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    
    # prototype.update(prototype_params)
    if @prototype.update(prototype_params)
      #binding.pry
      redirect_to action: :show, id: params[:id]
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to action: :index
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
end