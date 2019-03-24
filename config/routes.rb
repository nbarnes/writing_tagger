Rails.application.routes.draw do
  devise_for :users
  root to: "static#landing_page"
  resources :entries
  get 'tags/', to: 'tags#index'
  get 'tags/:tag', to: 'tags#show'
end
