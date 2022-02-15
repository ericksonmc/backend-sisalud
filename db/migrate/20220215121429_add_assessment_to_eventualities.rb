class AddAssessmentToEventualities < ActiveRecord::Migration[6.1]
  def change
    add_column :eventualities, :assessment, :text
  end
end
