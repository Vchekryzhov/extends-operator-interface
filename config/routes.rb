Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'info#index'
  get 'infos/:id', to: 'info#show', as: 'info'
  get 'infos', to: 'info#index'
  get '/set', to: 'data#set'
  get '/reviews/:machine_id', to: 'review#show', as: :reviews
  get '/get/:id', to: 'data#get'
  get '/v2/get/:id', to: 'data#v2_get'
  get '/init_vue/:id', to: 'data#init_vue'
  get '/v1/set_db_with_history', to: 'data#set_db_with_history'
  post '/v1/set_db_with_history', to: 'data#set_db_with_history'
  get '/v2/set_db_with_history', to: 'data#v2_set_db_with_history'
  post '/v2/set_db_with_history', to: 'data#v2_set_db_with_history'
  get '/documentations/:machine_id', to: 'documentation#index', as: :documentations
  get '/documentations/:id', to: 'documentation#show'
  get '/analytics/:id', to: 'data#analytic'
  post 'selected-locale', to:'application#selected_locale'
  get 'glass_get/:id', to: 'glass#get'
  post 'glass_set/:id', to: 'glass#set'
end
