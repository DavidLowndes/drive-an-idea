class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :idea_id
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
  end
end
