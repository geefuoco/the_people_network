class FriendRequestsController < ApplicationController

  def create
    @friend_request = current_user.outgoing_friend_requests.create(recipient_id: params[:recipient_id])
    @notification = Notification.create(
      user: current_user,
      recipient_id: params[:recipient_id],
      action: "friend_request",
      notifiable_type: "User",
      notifiable_id: params[:recipient_id]
    )

    respond_to do |format|
      format.js { flash.now[:notice] = "Friend request sent." }
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    redirect_back(fallback_location: root_path)
  end

  
end