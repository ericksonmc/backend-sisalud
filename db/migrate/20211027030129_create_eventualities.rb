class CreateEventualities < ActiveRecord::Migration[6.1]
  def change
    create_table :eventualities do |t|
      t.string :observations
      t.integer :event_type
      t.string :aasm_state
      t.string :password
      t.float :amount
      t.references :agreement, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
