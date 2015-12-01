Rails.application.routes.draw do

root "cities#index"
resources :cities do
  resources :companies do
    collection { post :import }
  end
  resources :wayfindings
  get '/company/floorplan' => 'companies#floorplan'
  get '/company/booklet' => 'companies#booklet'
  get '/company/logos' => 'companies#logos'
  get '/company/floorplan/a4' => 'companies#a4'
end

get '/upload' => 'companies#upload'



end
