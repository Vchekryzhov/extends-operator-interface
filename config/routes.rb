Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'info#index'
  get 'infos/:id', to: 'info#show', as: 'info'
  get 'infos', to: 'info#index'
  get '/set', to: 'data#set'
  get '/get/:id', to: 'data#get'
  get '/init_vue/:id', to: 'data#init_vue'
  get '/set_db', to: 'data#set_db'
  get '/documentations/:machine_id', to: 'documentation#index', as: :documentations
  get '/documentations/:id', to: 'documentation#show'
  get '/set_db', to: 'data#set_db'
  post 'selected-locale', to:'application#selected_locale'
end
