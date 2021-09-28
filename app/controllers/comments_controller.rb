class CommentsController < ApplicationController

  def new
    @comment = current_user.comments.build
  end

  def create  
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        flash.now[:notice] = "Comment posted."
        format.js
      else
        flash.now[:alert]= "Comment could not be posted at this time. Please try again later."
        format.js
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    flash.notice = "Comment deleted."
    redirect_back(fallback: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :body)
  end
end