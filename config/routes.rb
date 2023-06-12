Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/api/v0/forecast', to: 'forecasts#show'
  get '/api/v1/book-search', to: 'books#index'
end
