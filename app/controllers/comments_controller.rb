class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.user = current_user
    @comment.post = @post
    
    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to post_path(@post)
    else
      render "posts/show" # template, not a URL
    end
  end
end