class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  validate :enough_ingredients

  before_validation :reduce_quantity

  def enough_ingredients
    if ingredient.quantity <= 0
      error.add(:ingredient, "Not enough ingredients")
    end
  end

  def reduce_quantity
    self.ingredient.quantity -= 1
  end

end
