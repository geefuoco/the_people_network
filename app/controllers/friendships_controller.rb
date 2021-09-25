class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      flash[:notice] = "Added friend."
    else
      flash[:alert] = "Friend could not be added  at this time"
    end
    redirect_to root_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Friendship has been ended."
    redirect_to root_path
  end

end