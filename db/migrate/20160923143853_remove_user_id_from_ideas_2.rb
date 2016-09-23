class RemoveUserIdFromIdeas2 < ActiveRecord::Migration[5.0]
  def change
    remove_column :ideas, :user_id
  end
end
