class CreateMunicipalities < ActiveRecord::Migration[6.1]
  def change
    create_table :municipalities do |t|
      t.references :state, null: false, foreign_key: true
      t.string :title
      t.string :capital
      t.jsonb :parish

      t.timestamps
    end
  end
end
