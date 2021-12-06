class AddInsuracePeriodToAgreement < ActiveRecord::Migration[6.1]
  def change
    add_column :agreements, :insurance_period, :string
  end
end
