class Idea < ApplicationRecord
  belongs_to :user
  has_many :votes
  
  validates :text, presence: true, length: { minimum: 3 }
  
  def binary_voting_stats
    if votes.any?
      
      #Initialize vars
      total = 0
      positive_votes = 0
      negative_votes = 0
      
      votes.each do |vote|
        if vote.value == 1
          positive_votes += 1
          total += vote.value
        else
          negative_votes += 1
        end
        
      end
      percent_score = total.to_f / votes.count * 100
      
      return [percent_score, positive_votes, negative_votes]
      
    else
      'No votes!'
    end
  end
  
end
