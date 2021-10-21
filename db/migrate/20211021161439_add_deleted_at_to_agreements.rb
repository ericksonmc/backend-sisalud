class AddDeletedAtToAgreements < ActiveRecord::Migration[6.1]
  def change
    add_column :agreements, :deleted_at, :datetime
    add_index :agreements, :deleted_at
  end
end
