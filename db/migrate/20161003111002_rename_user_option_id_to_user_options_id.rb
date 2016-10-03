class RenameUserOptionIdToUserOptionsId < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :user_option_id, :user_options_id
  end
end
