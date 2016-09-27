class AddAnonymousCommentsToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :anonymous_comments?, :boolean, default: false
  end
end
