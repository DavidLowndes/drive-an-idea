class AddShowVotesAndAnonymousVotesToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :show_votes, :integer
    add_column :ideas, :anonymous_votes, :integer
  end
end
