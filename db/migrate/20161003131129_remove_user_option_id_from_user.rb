class RemoveUserOptionIdFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_option_id
  end
end
