Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #route for home page
  get "/", to: "pages#home", as: "root"
  
  #routes for listings
  get "/listings", to: "listings#index", as: "listings"
  post "/listings", to: "listings#create"
  get "/listings/new", to: "listings#new", as: "new_listing"
  get "/listings/new/confirm", to: "listings#confirm", as: "confirm_new_listing"
  get "/listings/:id/buy", to: "listings#buy", as: "buy_listing"
  get "/listings/:id", to: "listings#show", as: "listing"

  #routes for profiles
  get "/profile", to: "profiles#show", as: "profile"
  put "/profile", to: "profiles#update"
  patch "/profile", to: "profiles#update"
  get "/profile/edit", to: "profiles#edit", as: "edit_profile"
end
