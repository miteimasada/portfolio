Rails.application.routes.draw do

  resources :users do
    member do
      get :following, :followers
    end
  end

  get "users/:id/likes" => "users#likes"

  post 'users/create' => 'users#create'
  post 'users/:id/update' => 'users#update'

  resources :posts do
    resources :comments, only: :create
    get :search, on: :collection
    get :popular, on: :collection
  end

  namespace :admin do
    resources :users
    resources :posts
  end

  get 'admin/posts/:id/edit' => 'posts#edit'
  post 'admin/users/:id/update' => 'users#update'

  get '/' => 'home#top'
  get 'index/:id' => 'home#index'
  get 'timeline/:id' => 'home#timeline'
  get 'likes/:id' => 'home#likes'

  resources :relationships, only: [:create, :destroy]

  post "likes/:post_id/create" => "likes#create"
  delete "likes/:post_id/destroy" => "likes#destroy"

  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'

  resources :comments, only: :destroy

end
