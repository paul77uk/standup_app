Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resource :accounts

  get 'user/me', to: 'users#me', as: 'my_settings'
  patch 'user/update_me', to: 'users#update_me', as: 'update_my_settings'
  get 'user/password', to: 'users#password', as: 'my_password'
  patch 'user/update_password', to:'users#update_password', as:'my_update_password'

  scope 'account', as: 'account' do
    resources :users do
      member do
        get 's', to: 'users/standups#index', as: 'standups'
      end
    end
  end

  get 't/new', to: 'teams#new'
  get 't/:id/edit', to: 'teams#edit'
  get 't/:id/s', to: 'teams/standups#index', as: 'team_standups'
  get 't/:id/s/(:date)', to: 'teams/standups#index', as: 'team_standups_by_date'
  get 't/:id/(:date)', to: 'teams#show'
  resources :teams, path: 't'

  resources :standups, path: 's'

  get 'activity/mine'
  get 'activity/feed'

  get 'dates/:date', to: 'dates#update', as: 'update_date'

  get 'help', to: 'help#index'

  require "sidekiq/web"
  require 'sidekiq/cron/web'
  mount Sidekiq::Web, at: "/sidekiq"

  root to: 'activity#mine'
end
