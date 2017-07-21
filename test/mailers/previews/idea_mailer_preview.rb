# Preview all emails at http://localhost:3000/rails/mailers/idea_mailer
class IdeaMailerPreview < ActionMailer::Preview
  
  def send_idea
    idea = Idea.first
    company_user = User.find(idea.user_id)
    IdeaMailer.send_idea(idea, company_user)
  end
  
  def send_idea_comment
    idea = Idea.first
    comment = Comment.find_by(idea_id: idea.id)
    fuser = User.find(idea.user_id)
    IdeaMailer.send_idea_comment(comment, fuser, idea)
  end
  
  def send_vote_notification
    idea = Idea.first
    vote = Vote.find_by(idea_id: idea.id)
    IdeaMailer.send_vote_notification(vote)
  end
  
  def send_idea_closed
    idea = Idea.first
    IdeaMailer.send_idea_closed(idea)
  end
  
end
