class RenameShowVotesToRevealCurrentVotes < ActiveRecord::Migration[5.0]
  def change
    rename_column :ideas, :show_votes, :reveal_current_votes
  end
end
