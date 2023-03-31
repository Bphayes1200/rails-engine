Rails.application.routes.draw do
  
  
  namespace :api do 
    namespace :v1 do 
      get "merchants/find_all", to: "merchants#find_all"
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "merchant_items"
      end

      get "items/find", to: "items#find"

      resources :items do 
        resources :merchant, only: [:index], controller: "items_merchant"
      end 
    end
  end
end
