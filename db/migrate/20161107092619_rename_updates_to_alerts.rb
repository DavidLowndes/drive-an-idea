class RenameUpdatesToAlerts < ActiveRecord::Migration[5.0]
  def change
    rename_table :updates, :alerts
  end
end
