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
  get 'dashboard', to: 'pages#home'
  get 'admin', to: 'admin#dashboard'
  get '/auth/:provider/callback'=> 'login#omniauth'
  get 'login/:email'=> 'login#login', :as=>"login"
  get 'users/index'
  post 'users/create', to: 'users#new'
  get 'users/show', to: 'users#show'
  delete 'users/destroy'
end
