Rails.application.routes.draw do
  # For sidekiq dashboard
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # For delayed job
  match '/delayed_job' => DelayedJobWeb, :anchor => false, :via => %i[get post]

  mount ActionCable.server => '/cable'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth'
  }

  resources :articles do
    resources :comments
  end

  # For Api
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :articles do
        resources :comments
      end
    end
  end

  post 'auth_user' => 'authentication#auth_user'

  resources :articles do
    member do
      put 'like' => 'articles#like'
    end
  end

  resources :articles do
    member do
      put 'dislike' => 'articles#dislike'
    end
  end

  get '/all', to: 'articles#all'

  post '/export', to: 'articles#export'
  get '/export', to: 'articles#all'

  get '/import', to: 'articles#import'

  post '/generate', to: 'articles#generate'
  get '/generate', to: 'articles#import'

  devise_scope :user do 
  get '/users', to: 'users/registrations#new'
  end

  get '/articles/check_if_ready', to: 'articles#check_if_ready'

  root 'articles#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
