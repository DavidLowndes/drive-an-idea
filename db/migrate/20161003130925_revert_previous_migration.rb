class RevertPreviousMigration < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :user_options_id, :user_option_id
  end
end
