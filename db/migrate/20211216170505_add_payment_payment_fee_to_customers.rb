class AddPaymentPaymentFeeToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :payment_fee, :float
  end
end
