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
    @friend_request = FriendRequest.where("requestor_id = ? AND recipient_id = ?",current_user.id, params[:recipient_id])
    @friend_request.destroy
    redirect_to root_path
  end

  
end