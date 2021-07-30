class CreateCustomerDiseases < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_diseases do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :disease, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
