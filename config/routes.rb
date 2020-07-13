Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#home'
  get '/signin', to: 'session#new'
  post '/signin', to: 'session#create'
  get '/logout', to: 'session#delete'

  resources :users
  resources :transfers

  get '/request_payment', to: 'transfers#request_payment'
  get '/send_payment', to: 'transfers#send_payment'

  resources :users do
    get '/request_payment', to: 'transfers#request_payment'
    get '/send_payment', to: 'transfers#send_payment'
  end

  put '/transfer/:id/accept', to: 'transfers#accept'
  put '/transfer/:id/withdraw', to: 'transfers#withdraw'

  get '/auth/facebook/callback' => 'session#create'
  
end
