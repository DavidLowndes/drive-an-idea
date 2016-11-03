class AddFinalVerdictToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :final_verdict, :string, default: 'Undecided'
  end
end
