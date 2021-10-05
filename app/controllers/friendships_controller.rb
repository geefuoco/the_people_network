class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friend = User.find(params[:friend_id])
    @inverse_friendship = @friend.friendships.build(friend_id: current_user.id)
    @friend_request = FriendRequest.where("recipient_id = ? AND requestor_id = ?", current_user.id, @friend.id)
    if @friendship.save && @inverse_friendship.save
      flash[:notice] = "Added friend."
      @friend_request.destroy
    else
      flash[:alert] = "Friend could not be added at this time"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friend = User.find_by(id: @friendship.friend_id)
    @inverse_friendship = @friend.friendships.find_by(friend_id: current_user.id)
    @friendship.destroy
    @inverse_friendship.destroy
    flash[:notice] = "Friendship has been ended."
    redirect_back(fallback_location: root_path)
  end

end