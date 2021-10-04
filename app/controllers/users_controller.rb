class UsersController < ApplicationController
  before_action :get_recent_notifications

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
                  .order("created_at desc")
                  .paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.js
      format.html
    end
  end

end