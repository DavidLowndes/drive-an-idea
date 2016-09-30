class RenameActiveDaysToOpenDays < ActiveRecord::Migration[5.0]
  def change
    rename_column :ideas, :active_days, :open_days
  end
end
