class ChangeDateColumnDateTimeToDate < ActiveRecord::Migration[6.1]
  def change
    change_column :eventualities, :date, :date
  end
end
