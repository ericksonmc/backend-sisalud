class AddAasmStateToAgreements < ActiveRecord::Migration[6.1]
  def change
    add_column :agreements, :aasm_state, :string
    remove_column :agreements, :status, :integer
  end
end
