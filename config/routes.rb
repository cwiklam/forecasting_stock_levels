Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'home#landing_page'
  get '/get_products', to: 'home#get_products'
  resources :products, only: %i[index new create edit update destroy]
  resources :orders, only: %i[index new create]
  # Defines the root path route ("/")
  # root "articles#index"
end
