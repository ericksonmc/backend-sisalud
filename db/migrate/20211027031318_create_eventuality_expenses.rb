class CreateEventualityExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :eventuality_expenses do |t|
      t.references :eventuality, null: false, foreign_key: true
      t.references :scale, null: false, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
