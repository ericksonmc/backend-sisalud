# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.float :coverage
      t.float :payment_fee
      t.jsonb :coverage_items
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
