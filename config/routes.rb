Rails.application.routes.draw do
  resources :ideas do
    resources :comments
    resources :votes
  end
  devise_for :users, :controllers => { :registrations => 'user/registrations' }
  resources :user_options, only: [:show, :edit, :update]

  root 'pages#home'
  get 'my_ideas', to: 'users#show'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
end
