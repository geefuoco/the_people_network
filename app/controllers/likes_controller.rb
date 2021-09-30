class LikesController < ApplicationController
  before_action :get_post
  before_action :set_like, only: :destroy

  def create
    respond_to do |format|
      if already_liked?
        format.js { flash.now[:alert]= "Cannot like a post more than once !" }
      else
        @post.likes.create(user_id: current_user.id)
        format.js
      end
    end
  end

  def destroy
    
    respond_to do |format|
      if !(already_liked?)
        flash.now[:alert]= "Cannot unlike a post you havent liked"
        format.js
      else
        @like.destroy
        format.js 
      end
    end
  end
  
  private

  def get_post
    @post = Post.find(params[:post_id])
  end

  def set_like
    @like = @post.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end