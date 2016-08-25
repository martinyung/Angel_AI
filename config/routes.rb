Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static#index'

 	resources :sentiment_results, only: [:index, :create]
 	resources :filtered_results, only: [:index, :create]

  resources :users do
  	resources :tweets, only: [:create, :index, :show, :destroy]
  	resources :sentiment_results, only: [:show, :destroy]
  	resources :filtered_results, only: [:show, :destroy]
  end
end

