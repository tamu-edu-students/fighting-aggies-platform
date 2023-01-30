# frozen_string_literal: true

Rails.application.routes.draw do
  passwordless_for :users, at: '/', as: :auth
  resources :users
  root 'login#loginPage'
  namespace :api do
    namespace :v1 do
      get 'videos/index'
      post 'videos/create'
      get 'videos/show'
      delete 'videos/destroy'

      get 'visions/index'
      post 'visions/create'
      get 'visions/show'
      delete 'visions/destroy'

      get 'analyses/index'
      post 'analyses/create'
      get 'analyses/show'
      delete 'analyses/destroy'
    end
  end
  resource :users
  get '/admin_authenticate', to: 'application#admin_authenticate'
  get '/coach_authenticate', to: 'application#coach_authenticate'
  get '/authorize' => 'login#authorize'
  get 'dashboard', to: 'pages#home'
  get 'admin', to: 'admin#dashboard'
  get '/auth/:provider/callback' => 'login#omniauth', :as => 'omniauth'
  get 'login/:email' => 'login#login', :as => 'login'
  get 'logout' => 'application#logout', :as => 'logout'
  get 'dashboard', to: 'pages#home'
  get 'admin', to: 'admin#dashboard'
  get '/auth/:provider/callback' => 'login#omniauth'
  # get 'login/:email' => 'login#login', :as => 'login'
  get 'users/index'
  post 'users/create', to: 'users#new'
  get 'users/show', to: 'users#show'
  get 'users/:id/edit' => 'users#edit', :as => 'users_edit'
  delete 'users/destroy'

  get 'route_instances/index(/:player_id)(/:route_name)(/:play_name)(/:practice_id)', to: 'route_instances#index', as: 'route_instances'
  get 'route_instances/show', to: 'users#show'
  get 'route_instances/byplayer', to: 'route_instances#by_player', as: 'route_instances_by_player'

  get 'players/index', to: 'players#index'
  get '/players/:id', to: 'players#show', as: 'players_show'
  resources :practice_videos
  get '/videos' => 'practice_videos#index', :as => 'videos'

  default_url_options host: 'https://fighting-aggies-platform.herokuapp.com'
end
