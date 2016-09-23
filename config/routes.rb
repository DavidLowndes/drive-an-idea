Rails.application.routes.draw do
  devise_for :users
  
  root 'pages#home'
  get 'my_ideas', to: 'users#my_ideas'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
