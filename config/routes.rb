Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#home", as: "root"
  get "/listings", to: "listings#index", as: "listings"
  get "/listings/:id/buy", to: "listings#buy", as: "buy_listing"
  get "/listings/:id", to: "listings#show", as: "listing"
  get "/listings/new", to: "listings#new", as: "new_listing"
  get "/testshow", to: "test#show"
end
