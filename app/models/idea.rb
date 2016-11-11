# Idea model
class Idea < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :votes,    dependent: :destroy
  has_many :follows,  dependent: :destroy
  has_many :alerts,   dependent: :destroy

  validates :text, presence: true, length: { minimum: 3 }
  validates :open_days, presence: true,
                        numericality: { greater_than_or_equal_to: 0,
                                        less_than_or_equal_to: 31 }

  def closing_time
    # Get the date created, advance it by the specified number of days
    # and move the timer to the end of the day (23:59:59)
    if !force_close
      created_at.advance(days: open_days).end_of_day
    else
      updated_at
    end
  end

  def open?
    # Is the closing date in the future? Idea is still active.
    closing_time.future? && !force_close?
  end

  def closed?
    # Is the closing date in the past? Idea is closed.
    closing_time.past? || force_close?
  end

  def reveal_voter_details?
    reveal_voter_details == 1
  end

  def real_time_voting?
    real_time_voting == 1
  end

  def anonymous_comments?
    anonymous_comments == 1
  end

  def results_viewable?
    real_time_voting? || closed?
  end

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
    percentage_score = running_total.to_f / votes.count * 10
    [percentage_score, vote_counts]
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
    maximum_score = votes.count * 21
    percent_score = running_total.to_f / maximum_score * 100
    scores = [running_total, percent_score]
    [scores, vote_counts]
  end
end
