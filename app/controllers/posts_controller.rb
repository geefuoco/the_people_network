class PostsController < ApplicationController
  before_action :get_post_ids, only: [:index, :create]
  def index
    @search_results = User.where("name ILIKE ?", params[:search])
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
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:notice] = "Post successfully deleted"
    redirect_back(fallback_location: root_path)
  end

  private

    def post_params
      params.require(:post).permit(:body, :user_id)
    end

    def get_post_ids
      @ids = current_user.friends.pluck(:id) << current_user.id
    end
end