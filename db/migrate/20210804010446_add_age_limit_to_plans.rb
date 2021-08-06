class AddAgeLimitToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :age_limit, :integer
  end
end
