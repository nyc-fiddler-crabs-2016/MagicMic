class SessionsController < ApplicationController

  # skip_before_action :ensure_current_user [:new, :create, :destroy]

   def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username}"
      redirect_to :root
    else
      flash[:error] = "username or password is incorrect."
      render 'new'
  end
end

  def destroy
    session[:user_id] = nil
    flash[:success] = "GoodBye"
    redirect_to new_session_path
  end
end
