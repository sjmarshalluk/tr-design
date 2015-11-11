Rails.application.routes.draw do

root "pages#index"


resources :companies do
  collection { post :import }
end
resources :wayfindings
get '/upload' => 'companies#upload'
  get '/all' => 'companies#all'


end
