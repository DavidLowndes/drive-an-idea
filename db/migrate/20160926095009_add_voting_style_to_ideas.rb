class AddVotingStyleToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :voting_style, :string, default: "Binary"
  end
end
