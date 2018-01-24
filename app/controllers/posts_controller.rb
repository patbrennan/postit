class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  # GET /posts
  def index
    # default action
    @posts = Post.all
  end

  # GET /posts/:id
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
    @action = "Create"
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = User.first # TODO: change one we have authentication
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
  
  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
    # to permit everything, specify permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
