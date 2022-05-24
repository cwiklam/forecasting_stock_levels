Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#landing_page'
  get '/get_products', to: 'home#get_products'
  resources :products, only: %i[index new create destroy]
  resources :orders, only: %i[index new create]
  # Defines the root path route ("/")
  # root "articles#index"
end
