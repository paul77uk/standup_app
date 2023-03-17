Rails.application.routes.draw do
  get 'activity/mine'
  get 'activity/feed'

  root to: 'activity#mine'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
