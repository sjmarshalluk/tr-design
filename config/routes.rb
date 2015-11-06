Rails.application.routes.draw do

root "pages#index"


resources :companies do
  collection { post :import }
end
resources :wayfindings
get '/upload' => 'companies#upload'


end
