Rails.application.routes.draw do
  resources :ideas do
    resources :comments
    resources :votes
  end

  devise_for :users, :controllers => { :registrations => 'user/registrations' }
  resources :user_options, only: [:show, :edit, :update]
  resources :users, only: [:show]
  resources :friendships

  root 'pages#home'

  get 'alerted_ideas',      to: 'ideas#alerted_ideas'
  get 'open_ideas',         to: 'ideas#open_ideas'
  get 'closed_ideas',       to: 'ideas#closed_ideas'
  get 'escalated_ideas',    to: 'ideas#escalated_ideas'
  get 'discarded_ideas',    to: 'ideas#discarded_ideas'
  get 'followed_ideas',     to: 'ideas#followed_ideas'
  get 'not_followed_ideas', to: 'ideas#not_followed_ideas'
  
  get  'my_area',        to: 'users#my_area'
  get  'my_ideas',       to: 'users#my_ideas'
  get  'my_friends',     to: 'users#my_friends'
  get  'search_friends', to: 'users#search'
  post 'add_friend',     to: 'users#add_friend'
  
  get 'refresh_follows', to: 'follows#refresh_follows'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
end
