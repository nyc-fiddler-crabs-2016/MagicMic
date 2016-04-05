class UsersController < ApplicationController

  before_action :ensure_current_user, except: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
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
    @saved_broadcasts = Broadcast.find_by(id: @user.saved_broadcasts.id)
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
