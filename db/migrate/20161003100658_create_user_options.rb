class CreateUserOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_options do |t|
      t.integer :anonymous_comments_default, default: 0
      t.integer :real_time_voting_default,   default: 0
      t.integer :reveal_voter_details,       default: 0
      
      t.timestamps
    end
  end
end
