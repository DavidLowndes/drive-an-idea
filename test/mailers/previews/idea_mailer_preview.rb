# Preview all emails at http://localhost:3000/rails/mailers/idea_mailer
class IdeaMailerPreview < ActionMailer::Preview
  
  def send_idea
    idea = Idea.first
    company_user = User.find(idea.user_id)
    IdeaMailer.send_idea(idea, company_user)
  end
  
end
