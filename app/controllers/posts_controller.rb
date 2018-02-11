class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  # GET /posts
  def index
    # TODO: limit to 10 posts, not ALL posts (very expensive db transactions)
    @posts = Post.all.sort_by { |x| x.vote_count }.reverse
  end

  # GET /posts/:id
  def show
    @comment = Comment.new
    
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    @action = "Create"
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @action = "Create"

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else  # validation error
      render :new  # must use render (not redirect) to pass instance variables to view
    end
  end

  # GET /posts/:id/edit
  def edit
    @action = "Update"
  end

  # PATCH /posts/:id
  def update
    @action = "Update"

    if @post.update(post_params)
      flash[:notice] = "The post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])
    title = @post.title
    
    respond_to do |format|
      # format.html { redirect_to :back } # normal flow
      format.js do # ajaxified flow - will use the vote.js.erb file 
        if @vote.valid?
          flash.now[:notice] = "Vote counted for #{title}."
        else
          flash.now[:error] = "You've already voted for #{title}."
        end
      end
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
    # to permit everything, specify permit!
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end
end
