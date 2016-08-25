Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	#root 'static#index'
  	root 'admins#new'

	resources :users
		resources :sentiment_results, only: [:index, :create]
	 	resources :filtered_results, only: [:index, :create]


	resources :users do 
	  	resources :tweets 
	  		resources :sentiment_results, only: [:show,:destroy]
	  			 resources :filtered_results, only: [:show, :destroy]
	  end

 	resources :admins, only: [:new, :create]
  	get "/get_user" => "static#index"

end

