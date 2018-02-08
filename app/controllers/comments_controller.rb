class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find_by(slug: params[:post_id])
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
  
  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
    
    if @vote.valid?
      flash[:notice] = "Vote counted."
    else
      flash[:error] = "You already voted on that comment."
    end
    
    respond_to do |format|
      format.js
    end
  end
end