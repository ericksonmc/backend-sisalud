class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :firstname, not: nil
      t.string :second_name, not: nil
      t.string :last_name, not: nil
      t.string :dni, not: nil
      t.date :birthday
      t.string :legal_representative
      t.jsonb :address
      t.string :phone, not: nil
      t.string :secondary_phone
      t.string :email, not: nil
      t.string :activity
      t.boolean :main
      t.integer :age
      t.integer :sex
      t.string :size
      t.belongs_to :parent, foreign_key: { to_table: :customers }
      t.jsonb :diagnosis
      t.references :plan, null: false, foreign_key: true
      t.float :coverage_reference
      t.float :coverage
      t.boolean :is_insured?
      t.string :customer_code

      #indexs
      t.index :dni
      t.index :coverage
      t.index :coverage_reference
      t.index :email
      t.index :customer_code

      t.timestamps
    end
  end
end
