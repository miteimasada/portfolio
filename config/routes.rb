Rails.application.routes.draw do

  resources :search do
    get :search, on: :collection
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'

  get 'users/new'
  post 'users/:id/update' => 'users#update'
  get 'users/:id/edit' => 'users#edit'
  post 'users/create' => 'users#create'
  get 'signup' => 'users#new'
  get 'users/index'
  get 'users/:id' => 'users#show'
  get "users/:id/likes" => "users#likes"

  get '/' => 'home#top'
  resources :posts do
    resources :comments, only: :create
  end
  resources :comments, only: :destroy
end
