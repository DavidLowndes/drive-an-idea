class AddVotingStyleDefaultToUserOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :user_options, :voting_style_default, :string, default: '5 Stars'
  end
end
