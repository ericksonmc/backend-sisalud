class CreateScales < ActiveRecord::Migration[6.1]
  def change
    create_table :scales do |t|
      t.string :title
      t.float :amount
      t.integer :category
      t.integer :status

      t.timestamps
    end
  end
end
