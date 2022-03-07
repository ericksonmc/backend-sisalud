class AddRecipeColumnsToEventualities < ActiveRecord::Migration[6.1]
  def change
    add_column :eventualities, :indications, :string
    add_column :eventualities, :recipe, :string
  end
end
