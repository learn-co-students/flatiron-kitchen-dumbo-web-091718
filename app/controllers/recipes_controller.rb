class RecipesController < ApplicationController
  before_action :get_recipe, only: [:show, :edit, :update, :destroy]
  def index
    @recipes = Recipe.all
  end

  def show
  end

  def edit
    @ingredients = Ingredient.all
  end

  def update
    @recipe.update(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :edit
    end
  end

  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save

      redirect_to @recipe
    else
      render :new
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def get_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, ingredient_ids: [])
  end

end
