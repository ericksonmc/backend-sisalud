class AddDiagnosisToAgreements < ActiveRecord::Migration[6.1]
  def change
    add_column :agreements, :diagnosis, :jsonb
  end
end
