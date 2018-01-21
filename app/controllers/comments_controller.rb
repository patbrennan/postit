class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    
    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to post_path(@post)
    else
      render "posts/show" # template, not a URL
    end
  end
end