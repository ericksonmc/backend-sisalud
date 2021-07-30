class AddWeightToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :weight, :string
  end
end
