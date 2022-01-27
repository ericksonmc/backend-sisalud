class CreateCoverageItems < ActiveRecord::Migration[6.1]
  def change
    create_table :coverage_items do |t|
      t.string :title
      t.jsonb :scale_items, default: []

      t.timestamps
    end
  end
end
