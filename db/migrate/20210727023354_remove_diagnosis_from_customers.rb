class RemoveDiagnosisFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :diagnosis, :jsonb
  end
end
