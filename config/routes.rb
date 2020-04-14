Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :creatures

    get '/fish', to: 'creatures#fish'
    get '/bugs', to: 'creatures#bugs'
    get '/current', to: 'creatures#current'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
