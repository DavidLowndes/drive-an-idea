class RenameRevealCurrentVotesToRealTimeVoting < ActiveRecord::Migration[5.0]
  def change
    rename_column :ideas, :reveal_current_votes, :real_time_voting
  end
end
