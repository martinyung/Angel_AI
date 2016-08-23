Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static#index'


  resources :users
  resources :sentiment_results


  resources :users do 
  	resources :tweets 
  end





  



end

