class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, except: [:new, :create]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def show; end
  
  def edit; end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "User updated."
      redirect_to user_path
    else
      render :edit
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Registration completed."
      redirect_to user_path(@user)
    else
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
end