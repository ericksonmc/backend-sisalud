class ChangeAgeLimitFromPlans < ActiveRecord::Migration[6.1]
  def change

    def up
      change_column :plans, :age_limit, :float
      change_column :plans, :age_min, :float
      change_column :customers, :age, :float
    end

    def down
      change_column :plans, :age_limit, :integer
      change_column :plans, :age_min, :integer
      change_column :customers, :age, :integer
    end

  end
end
