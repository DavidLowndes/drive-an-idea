class AddUserIdAndUserOptionIds < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_option_id, :integer
    
    add_column :user_options, :user_id, :integer
  end
end
