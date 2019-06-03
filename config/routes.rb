Rails.application.routes.draw do
  root 'surveys#index'

  post 'requests/new' => 'requests#selection'

  devise_for :users, :path_prefix => 'my'
  resources :users
  resources :requests
  resources :surveys
  resources :fichiers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
