class AddActiveDaysToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :active_days, :integer
  end
end
