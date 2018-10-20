class AddQuantitytoIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :quantity, :integer, default: 10
  end
end
