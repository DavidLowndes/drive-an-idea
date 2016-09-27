class ChangeColumnNameInIdeas < ActiveRecord::Migration[5.0]
  def change
    rename_column :ideas, :anonymous_comments?, :anonymous_comments
  end
end
