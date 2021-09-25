class PostsController < ApplicationController

  def index
    @posts = Post.all
    #change eventually to show only user posts and friend posts with a scope in the post class
  end
  
  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def post_params
      params.require(:post).permit(:body, :user_id)
    end
end