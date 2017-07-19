class IdeaMailer < ApplicationMailer
  default from: 'support@firstb2b.com'
  helper :ideas # This allows helpers in the mailer.

  def send_idea(idea, company_user)
    @idea = idea
    @company_user = company_user
      mail(
        from: 'DriveAnIdea <support@firstb2b.com>',
        to: company_user.email,
        subject: "A New Idea from DAI"
      )
    
  end

  def send_template(email_addr, email_template)
    @email_addr = email_addr
    @email_template = email_template

    mail(
      from: email_template.first.email_from,
      subject: email_template.first.email_subject,
      to: email_addr
    ) # Helper Methods simply use the template ID to find the 'from' and 'subject'.
  end
end
