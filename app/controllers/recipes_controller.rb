require 'pry'
class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.valid?
      @recipe.save
      if params[:recipe][:ingredient_ids].count > 1
        params[:recipe][:ingredient_ids].pop
        ingredients = params[:recipe][:ingredient_ids]
        ingredients.each {|ingredient| RecipeIngredient.create(recipe_id: @recipe.id, ingredient_id: ingredient)}
      end
      redirect_to @recipe
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    if params[:recipe][:ingredient_ids].count > 0
      params[:recipe][:ingredient_ids].pop
      @ingredients = params[:recipe][:ingredient_ids]
      @ingredients = @ingredients.map {|id| Ingredient.find(id.to_i)}
    end

    if @recipe.valid?
      @recipe.ingredients = @ingredients
      @recipe.save
      redirect_to @recipe
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredient_ids)
  end
end
