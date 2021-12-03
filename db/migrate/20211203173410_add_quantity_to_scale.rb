class AddQuantityToScale < ActiveRecord::Migration[6.1]
  def change
    add_column :scales, :quantity, :integer, default: nil
  end
end
