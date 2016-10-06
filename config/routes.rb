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

  get 'open_ideas', to: 'ideas#open_ideas'

  get 'my_ideas', to: 'users#my_ideas'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
end
