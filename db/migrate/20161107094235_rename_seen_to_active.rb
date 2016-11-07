class RenameSeenToActive < ActiveRecord::Migration[5.0]
  def change
    rename_column :alerts, :seen, :active
  end
end
