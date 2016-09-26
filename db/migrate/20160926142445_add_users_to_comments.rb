class AddUsersToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :users, :string
  end
end
