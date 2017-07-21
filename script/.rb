#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))
puts Rails.env

# Check Whether an Idea is still open or not. Run at midnight every night
puts 'Checking Ideas'
@ideas = Idea.where(closed: [false, nil])


@ideas.each do |idea|
  puts idea
  if idea.closed?
    IdeaMailer.send_idea_closed(idea).deliver
    #idea.closed = true
    #idea.save
  end
end