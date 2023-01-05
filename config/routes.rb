Rails.application.routes.draw do
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
  namespace :api do
    namespace :v2 do
      get 'users/index', to: 'admin#dashboard'
      post 'users/create'
      get 'users/show'
      delete 'users/destroy'
    end
  end
end
