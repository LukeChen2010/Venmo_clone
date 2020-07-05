Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#home'
  get '/signin', to: 'session#new'
  post '/signin', to: 'session#create'
  get '/logout', to: 'session#delete'

  resources :users
end
