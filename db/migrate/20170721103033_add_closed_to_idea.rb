class AddClosedToIdea < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :closed, :boolean
  end
end
