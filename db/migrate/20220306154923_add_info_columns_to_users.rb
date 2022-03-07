class AddInfoColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :dni, :string
    add_column :users, :mpps, :string
  end
end
