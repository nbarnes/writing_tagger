Rails.application.routes.draw do
  devise_for :users
  get 'entries/search/(:content_search)/(:tag_search)', to: 'entries#index', as: 'entries_search'
  resources :entries
  get 'tags/', to: 'tags#index'
  get 'tags/:tag', to: 'tags#show', as: 'tag'
  root to: "static#landing_page", as: 'landing_page'
  get '/*foo', to: redirect('/')
end
