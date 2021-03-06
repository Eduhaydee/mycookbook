class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisine = Cuisine.all
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisine = Cuisine.all
      flash[:errors] = "Você deve informar todos os dados da receita"
      render :new
    end
  end
  
  def edit
    @recipe = Recipe.find(params[:id]) 
    @recipe_types = RecipeType.all
    @cuisine = Cuisine.all
  end

  def update
    @recipe = Recipe.find(params[:id]) 
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisine = Cuisine.all
      flash[:errors] = "Você deve informar todos os dados da receita"
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:errors] = "Receita deletada com sucesso"
    redirect_to root_path
  end

  def search
    @recipes = Recipe.where("title LIKE '%#{params[:q]}%'")
  end

  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method, :photo)
  end
  
  
end