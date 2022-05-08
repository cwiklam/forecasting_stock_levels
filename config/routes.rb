Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#landing_page'
  resources :products, only: %i[index]
  # Defines the root path route ("/")
  # root "articles#index"
end
