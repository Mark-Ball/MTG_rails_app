class ProfilesController < ApplicationController
    before_action :authenticate_user!
    
    def show
        @user = current_user
        @address = Address.where(user_id: current_user.id)[0]
    end

    def edit
        @user = current_user
    end

    def update
        current_user.update(
            name: params[:profile][:name],
            alias: params[:profile][:alias],
            email: params[:profile][:email]
        )

        if current_user.address.nil?
            current.user.create_address(
                address: params[:address][:address],
                suburb: params[:address][:suburb],
                city: params[:address][:city],
                country: params[:address][:country],
                postcode: params[:address][:postcode]
            )
        else
            current_user.address.update(
                address: params[:address][:address],
                suburb: params[:address][:suburb],
                city: params[:address][:city],
                country: params[:address][:country],
                postcode: params[:address][:postcode] 
            )
        end
    end

    def my_listings
        #creating the array of listings
        @my_listings = current_user.listings
        
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