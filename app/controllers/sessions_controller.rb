class SessionsController < ApplicationController

  # skip_before_action :ensure_current_user [:new, :create, :destroy]

  def new
    render 'new'
  end

  def create

    @user = User.find_by(username: params[:username])
    binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to :root
    else
      flash.alert = 'Incorrect login info.'
      redirect_to :back
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
