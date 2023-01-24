class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # def index
  #   @categories = current_user.categories
  #   redirect_to :authenticated_root # will redirect to 'tasks#index'
  # end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = current_user.categories.build
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    # modify params to capitalize title and remove whitespaces
    params[:category][:title] = params[:category][:title].titleize.strip 

    # search the Category table if the category provided by the user already exists, 
    # it will return and assign it if it does, otherwise it will create a new record.
    @category = current_user.categories.find_or_create_by(category_params)

    if @category.save
      redirect_to @category, notice: 'Category successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to :authenticated_root, notice: 'Category deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title)
    end
end
