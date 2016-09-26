class Idea < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  
  validates :text, presence: true, length: { minimum: 3 }
  
  def binary_voting_stats
    #Initialize vars
    running_total = 0
    positive_votes = 0
    negative_votes = 0
    
    votes.each do |vote|
      if vote.value == 1
        positive_votes += 1
        running_total += vote.value
      else
        negative_votes += 1
      end
      
    end
    percent_score = running_total.to_f / votes.count * 100
    
    return [ percent_score,
             positive_votes,
             negative_votes ]
  end
  
  def five_stars_voting_stats
    #Init vars
    one_star_votes = 0
    two_star_votes = 0
    three_star_votes = 0
    four_star_votes = 0
    five_star_votes = 0
    running_total = 0
    
    votes.each do |vote|
      case vote.value
      when 1
        one_star_votes += 1
      when 2
        two_star_votes += 1
      when 3
        three_star_votes += 1
      when 4
        four_star_votes += 1
      when 5
        five_star_votes += 1
      end
      running_total += vote.value        
    end
    average_score = running_total.to_f / votes.count 
    return [ average_score, 
             one_star_votes,
             two_star_votes, 
             three_star_votes,
             four_star_votes,
             five_star_votes ]
  end
  
  
end
