Rails.application.routes.draw do
  resources :posts
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  
  root to: "home#index"
  get '/sendRequest' => 'home#sendRequest'
  get '/acceptRequest' => 'home#acceptRequest'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
