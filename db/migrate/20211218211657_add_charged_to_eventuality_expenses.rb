class AddChargedToEventualityExpenses < ActiveRecord::Migration[6.1]
  def change
    add_column :eventuality_expenses, :charged, :boolean, default: false
  end
end
