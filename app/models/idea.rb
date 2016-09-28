class Idea < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :text, presence: true, length: { minimum: 3 }
  validates :active_days, presence: true,
                          numericality: { greater_than: 0, less_than: 7 }

  def binary_voting_stats
    # Initialize vars
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

    [percent_score, positive_votes, negative_votes]
  end

  def one_to_ten_voting_stats
    # Init vars
    running_total = 0
    vote_counts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    votes.each do |vote|
      vote_counts[vote.value - 1] += 1
      running_total += vote.value
    end
    average = running_total.to_f / votes.count
    [average, vote_counts]
  end

  def five_stars_voting_stats
    # Init vars
    running_total = 0
    vote_counts = [0, 0, 0, 0, 0]

    votes.each do |vote|
      vote_counts[vote.value - 1] += 1
      running_total += vote.value
    end

    average = running_total.to_f / votes.count
    [average, vote_counts]
  end

  def fibonacci_voting_stats
    # Init couting vars
    running_total = 0
    vote_counts = [0, 0, 0, 0, 0, 0, 0]

    votes.each do |vote|
      case vote.value
      when 1..3
        vote_counts[vote.value - 1] += 1
      when 5
        vote_counts[3] += 1
      when 8
        vote_counts[4] += 1
      when 13
        vote_counts[5] += 1
      when 21
        vote_counts[6] += 1
      end
      running_total += vote.value
    end
    average = running_total.to_f / votes.count
    [average, vote_counts]
  end
end
