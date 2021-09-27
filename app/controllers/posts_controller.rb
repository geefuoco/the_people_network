class PostsController < ApplicationController
  before_action :get_post_ids, only: [:index, :create]
  def index
    @posts = Post.where(user_id: @ids)
                 .paginate(page: params[:page], per_page: 15)
                 .order("created_at desc")
                 .includes(:user)
                 
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def show

  end

  def new
    @post = current_user.posts.build

    respond_to do |format|
      format.js
    end
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        flash.now[:notice] = "Post created."
        format.js 
      else
        format.js { flash.now[:alert] = "Post could not be created at this time. Try again later." }
      end
    end
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

    def get_post_ids
      @ids = current_user.friends.pluck(:id) << current_user.id
    end
end