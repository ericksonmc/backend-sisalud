class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :title
      t.string :capital
      t.jsonb :cities

      t.timestamps
    end
  end
end
