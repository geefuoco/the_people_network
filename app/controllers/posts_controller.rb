class PostsController < ApplicationController
  before_action :get_post_ids, only: [:index, :create]
  before_action :get_recent_notifications, only: [:index, :show]
  def index
    @search_results = User.where("name ILIKE ?", params[:search])
    @posts = Post.where(user_id: @ids)
                 .paginate(page: params[:page], per_page: 15)
                 .order("created_at desc")
                 .includes(:user, :comments)
                 
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page], per_page: 5).includes(:comments)
    respond_to do |format|
      format.js
      format.html
    end
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
        format.js { flash.now[:notice] = "Post created." }
      else
        format.js { flash.now[:alert] = "Post could not be created at this time. Try again later." } 
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:notice] = "Post successfully deleted"
    redirect_back(fallback_location: root_path)
  end

  private

    def post_params
      params.require(:post).permit(:body, :user_id, :image)
    end

    def get_post_ids
      @ids = current_user.friends.pluck(:id) << current_user.id
    end
end