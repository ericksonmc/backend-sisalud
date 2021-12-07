class AddDateToEventualities < ActiveRecord::Migration[6.1]
  def change
    add_column :eventualities, :date, :timestamp
  end
end
