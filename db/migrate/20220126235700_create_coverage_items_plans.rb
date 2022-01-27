class CreateCoverageItemsPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :coverage_items_plans do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :coverage_item, null: false, foreign_key: true
      t.integer :waiting_period
      t.integer :coverage

      t.timestamps
    end
  end
end
