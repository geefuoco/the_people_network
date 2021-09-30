class CommentsController < ApplicationController
  before_action :find_commentable, except: :destroy

  def new
  end

  def create  
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        @comment_post = get_post
        flash.now[:notice] = "Comment posted."
        format.js { @comment_post }
      else
        flash.now[:alert]= "Comment could not be posted at this time. Please try again later."
        format.js { render json: @comment.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.notice = "Comment deleted."
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    if params[:post_id]
      @commentable = Post.find_by_id(params[:post_id])
    else
      @commentable = Comment.find_by_id(params[:comment_id])
    end
  end

  def get_post
    Post.find_by_id(params[:post_id]) ||
      find_top_post(Comment.find(params[:comment_id]))
  end

  def find_top_post(comment)
    if comment.commentable_type == "Post"
      return Post.find_by_id!(comment.commentable_id)
    end
    find_top_post(Comment.find_by_id!(comment.commentable_id))
  end
end