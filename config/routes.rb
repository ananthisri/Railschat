Rails.application.routes.draw do
#  get 'home/index' 
  root 'home#index'

  devise_for :users

  mount RailsAdmin::Engine => '/admin' ,  as: 'rails-admin'
  resources :conversations, only: [:create] do
  	member do
  		post :close
  	end
  		resources :messages, only: [:create]
  	
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
