class RemoveCommenterAndUsersFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :commentator
    remove_column :comments, :users
  end
end
