# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :firstname, null: true
      t.string :second_name, null: true
      t.string :last_name, null: true
      t.string :dni, null: true
      t.date :birthday
      t.string :legal_representative
      t.jsonb :address
      t.string :phone, null: true
      t.string :secondary_phone
      t.string :email, null: true
      t.string :activity
      t.boolean :main
      t.integer :age
      t.integer :sex
      t.string :size
      t.belongs_to :parent, foreign_key: { to_table: :customers }
      t.jsonb :diagnosis
      t.references :plan, null: true, foreign_key: true
      t.float :coverage_reference
      t.float :coverage
      t.boolean :is_insured
      t.string :customer_code

      # indexs
      t.index :dni
      t.index :email

      t.timestamps
    end
  end
end
