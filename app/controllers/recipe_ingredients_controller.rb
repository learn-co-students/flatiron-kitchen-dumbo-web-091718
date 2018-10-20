class RecipeIngredientIngredientsController < ApplicationController
  before_action :get_recipe_ingredient, only: [:show, :edit, :update, :destroy]
  def index
    @recipe_ingredients = RecipeIngredient.all
  end

  def show
  end

  def edit
  end

  def update
    @recipe_ingredient.update(recipe_ingredient_params)
    if @recipe_ingredient.save
      redirect_to @recipe_ingredient
    else
      render :edit
    end
  end

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def create
    @recipe_ingredient = RecipeIngredient.create(recipe_ingredient_params)
    if @recipe_ingredient.save
      redirect_to @recipe_ingredient
    else
      render :new
    end
  end

  def destroy
    @recipe_ingredient.destroy
    redirect_to recipe_ingredients_path
  end

  private

  def get_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id)
  end

end
