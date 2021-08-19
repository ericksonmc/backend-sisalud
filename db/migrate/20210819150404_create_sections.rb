class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.string :pretty_name
      t.integer :module_name

      t.timestamps
    end
  end
end
