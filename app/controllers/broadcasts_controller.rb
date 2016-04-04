class BroadcastsController < ApplicationController

 # before_action :ensure_ownership

  def index
    @broadcasts = Broadcast.all
  end

  def new
    @broadcast = Broadcast.new
  end

  def create
    @broadcast = Broadcast.new(broadcast_params)
    if @broadcast.save
      redirect_to :root
    else
      redirect_to :back
    end
  end

  def show
    @broadcast = Broadcast.find(params[:id])
  end

  def edit
    @broadcast = Broadcast.find(params[:id])
  end

  def update
    @broadcast = Broadcast.find(params[:id])
    if @broadcast.update(broadcast_params)
      redirect_to :root
    else
      redirect_to :back
    end
  end

  def destroy
    broadcast = Broadcast.find(params[:id])
    broadcast.destroy
    redirect_to root_path
  end

  # def belongs_to_current_user?
  #   current_user.id == self.creator_id
  # end

  # def ensure_ownership
  #   unless self.belongs_to_current_user?
  #     flash.alert = "Try again"
  #     redirect_to root_path
  #   end
  # end

  private

  def broadcast_params
    params.require(:broadcast).permit(:topic, :datetime, :duration).merge(speaker_id: current_user.id)
  end

end
