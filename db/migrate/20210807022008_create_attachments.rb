class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string :description
      t.integer :fileable_id, null: true
      t.string :fileable_type, null: true

      t.timestamps
    end
  end
end
