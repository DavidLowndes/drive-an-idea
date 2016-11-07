class CreateUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :updates do |t|
      t.integer :user_id
      t.integer :idea_id
      t.integer :seen,     default: 0
      
      t.timestamps
    end
  end
end
