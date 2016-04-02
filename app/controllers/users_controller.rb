class UsersController < ApplicationController

  before_action :ensure_current_user, except: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.alert = "Something went awry. Please try again"
      render 'form'
    end

  end

  def show
    @user = User.find(params[:id])
    @broadcasts = Broadcast.upcoming.where(speaker_id: @user.id)
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end


end
