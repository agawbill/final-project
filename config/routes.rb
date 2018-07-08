Rails.application.routes.draw do


  resources :pictures
  devise_for :admins
  # get "/comments/new" => "blogs#new"
  get "/comments" => "comments#create"
  get "/profile/:id" => "users#show"
  root "blogs#index"
  devise_for :users
  # devise_for :admins
  resources :users
  resources :admins
  resources :blogs
  resources :comments
  resources :searches
  resources :lists
  # get 'searches' => 'searches#searchMovies'

  # resources :searches




  # get "/searches" => "searches#index", as: :search

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
