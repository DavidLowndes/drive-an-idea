class RenameShowAnonymousVotesToRevealVoterDetails < ActiveRecord::Migration[5.0]
  def change
    rename_column :ideas, :anonymous_votes, :reveal_voter_details
  end
end