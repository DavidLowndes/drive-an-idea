namespace :send_closed_email do
  desc 'This task sends the idea closed email'
  
  task send: :environment do
    @ideas = Idea.where(closed: [false, nil])
    puts @ideas ? 'Ideas Found' : 'No Ideas!'
    @ideas.each do |idea|
      if idea.is_closed?
        puts 'Sending Email'
        IdeaMailer.send_idea_closed(idea).deliver
        puts 'Closing Idea'
        puts idea.closed
        idea.closed = true
        puts idea.closed
        puts 'Saving Idea'
        idea.save
        puts 'Idea Saved!'
      end      
    end
    puts 'Finished Ideas'    
  end
end
