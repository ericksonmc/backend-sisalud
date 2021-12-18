class CreateEventualityExpenseManuals < ActiveRecord::Migration[6.1]
  def change
    create_table :eventuality_expense_manuals do |t|
      t.float :amount
      t.references :eventuality, null: false, foreign_key: true
      t.string :title
      t.boolean :charged, default: false

      t.timestamps
    end
  end
end
