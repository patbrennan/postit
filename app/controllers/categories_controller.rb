class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]
  
  # GET /categories/new
  def new
    @category = Category.new
  end
  
  # POST /categories
  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:notice] = "Category created."
      redirect_to new_category_path
    else
      render :new
    end
  end
  
  # GET /categories/:id
  def show
    @category = Category.find_by(slug: params[:id])
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end