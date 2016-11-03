class AddForceCloseToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :force_close, :integer, default: 0
  end
end
