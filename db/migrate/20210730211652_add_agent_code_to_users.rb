class AddAgentCodeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :agent_code, :string
  end
end
