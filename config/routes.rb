Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'infos/:id', to: 'info#show'
  get '/set', to: 'data#set'
  get '/get/:id', to: 'data#get'
end
