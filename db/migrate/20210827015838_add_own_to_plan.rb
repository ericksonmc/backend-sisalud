class AddOwnToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :own, :boolean, default: false
    add_column :plans, :age_min, :integer, default: 0
  end
end
