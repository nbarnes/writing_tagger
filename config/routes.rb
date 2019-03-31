Rails.application.routes.draw do
  devise_for :users
  root to: "static#landing_page", as: 'landing_page'
  get 'entries(/:search_terms)', to: 'entries#index', as: 'entries'
  resources :entries, except: :index
  get 'tags/', to: 'tags#index'
  get 'tags/:tag', to: 'tags#show', as: 'tag'
end
