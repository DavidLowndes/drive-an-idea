class IdeaMailer < ApplicationMailer
  default from: 'support@firstb2b.com'
  helper :ideas, :comments # This allows helpers in the mailer.

  def send_idea(idea, company_user)
    @idea = idea
    @company_user = company_user
      mail(
        from: 'DriveAnIdea <support@firstb2b.com>',
        to: company_user.email,
        subject: "+ New Idea - DriveAnIdea"
      )
    
  end

  def send_idea_comment(comment, user, idea)
    @comment = comment
    @user = user
    @idea = idea

    mail(
    from: 'DriveAnIdea <support@firstb2b.com>',
    to: user.email,
    subject: "+ New Comment has been added to an Idea you follow.. - DriveAnIdea"
    )
  end
  
end
