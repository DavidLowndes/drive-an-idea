class RenameRevealVoterDetailsToAddDefault < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_options, :reveal_voter_details,                                                          :reveal_voter_details_default
  end
end
