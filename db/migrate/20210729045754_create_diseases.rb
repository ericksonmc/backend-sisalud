class CreateDiseases < ActiveRecord::Migration[6.1]
  def change
    create_table :diseases do |t|
      t.string :title
      t.boolean :has_description
      t.jsonb :list_diases, default: []
      t.integer :order
      t.timestamps
    end
  end
end
