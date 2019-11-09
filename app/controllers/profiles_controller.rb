class ProfilesController < ApplicationController
    before_action :authenticate_user!
    
    def show
        @user = current_user
    end

    def edit
        @user = current_user
    end

    def update
        whitelisted_user_params = params.require(:user).permit(:name, :alias, :email)
        whitelisted_address_params = params.require(:address).permit(:address, :suburb, :city, :country, :postcode)
        whitelisted_image = params.require(:user).permit(:image)

        current_user.update(whitelisted_user_params)

        current_user.update(image: params[:user][:image]) if params[:user][:image]

        if current_user.address.nil?
            current_user.create_address(whitelisted_address_params)
        else
            current_user.address.update(whitelisted_address_params)
        end
        redirect_to(profile_path)
    end

    def my_listings
        #get an array of the user's listing ids
        listings_ids = current_user.listings.ids
        #get an array of the sold items listing ids
        sold_ids = Purchase.all.map { |i| i.listing_id }
        #subtract them to get array of ids for items sold by this user which are still available
        still_available = listings_ids - sold_ids
        #passing only listings owned by the user which are still available to the view
        @my_listings = Listing.find(still_available)
        
        #creating the array of sold items
        list_of_sales = Listing.where(user_id: current_user.id).ids & Purchase.all.map { |i| i.listing_id }
        @sold = Listing.find(list_of_sales)

        #creating the array of purchased items
        list_of_purchases = current_user.purchases.map { |i| i.listing_id }
        @purchased = Listing.find(list_of_purchases)

        @purchases = Purchase.all
        @cards = Card.all
    end
end