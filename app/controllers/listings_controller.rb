class ListingsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    #called when user clicks "Browse" in the top bar
    #sends data to listings/index.html.erb
    def index
         if params[:search]
            #eager loading the cards associated with the listings
            #then nested eager load the images associated with those cards
            listings = Listing.includes(card: {image_attachment: :blob}).all
            
            #calling a custom method 'purchase_ids' on the purchase model to return an array of purchase ids
            purchases = Purchase.purchase_ids
    
            listings_available = listings.ids - purchases
    
            search = "%#{params[:search]}%"
            
            #calling a custom method 'search' on Card called to find records matching the name input
            @listings = listings.where(id: listings_available).where(card_id: Card.search(search).ids).uniq { |l| l.card_id }
        else
            #eager loading the purchases and cards with their attached images
            listings = Listing.includes(:purchase, card: {image_attachment: :blob}).all

            #removing the listings which have been purchased from the available listings
            listings_records = []
            listings.each { |listing| 
                listings_records.push(listing) unless listing.purchase
            }

            @listings = listings_records.uniq { |l| l.card_id }
        end
    end

    #called when user clicks a card on listings/index.html.erb
    #sends data to listings/show.html.erb
    def show
        #query to find listing to show
        #eager load the card associated with the listing
        #then nested eager load the listings associated with that card
        @listing = Listing.includes(card: :listings).find(params[:id])

        #get all ids of listings of this card
        listings_ids = @listing.card.listings.ids

        #get the listing ids of sold listings
        purchases_ids = Purchase.purchase_ids

        #calculate the list of ids for available listings
        listings_available_ids = listings_ids - purchases_ids

        #get the list of records for available listing
        @listings = Listing.where(id: listings_available_ids)
    end

    #called when user clicks "Buy" on the show page
    #sends data to listings/buy.html.erb. 
    def buy
        #query to find listing to buy
        @listing = Listing.find(params[:id])
        #query to find the image attached to the card attached to the listing
        @card_image = @listing.card.image
        #query to find the name attached to the card attached to the listing
        card_name = @listing.card.name

        session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
                name: card_name,
                amount: @listing.price,
                images: [@listing.card.imageUrl],
                currency: 'aud',
                quantity: 1,
            }],
            payment_intent_data: {
                metadata: {
                    user_id: current_user.id,
                    listing_id: @listing.id
                }
            },
            success_url: "#{root_url}payments/success",
            cancel_url: "#{root_url}listings"
        )
    
        @session_id = session.id
    end

    #called when user clicks "Search" on listings/new.html.erb
    #sends data to listings/new.html.erb
    def new
        #get an empty record of Card to send to the view
        @card = Card.new

        if params[:card]
            #query to find a card with a specific name and set a per our search
            @cards = Card.where(name: params[:card][:name]).where(set: params[:card][:set])
        else
            #if there is no search, there is nothing to render, send nil
            @cards = nil
        end
    end

    #called when user clicks "Yes" button on listings/new => new.html.erb
    #sends data to listings/confirm.html.erb
    def confirm_new
        #query to find the correct record to send to the view
        @card = Card.find(params[:card][:id])
        @empty_search = params[:empty_search]
    end

    #called with "Create listing" button on /listings/new/confirm => confirm.html.erb
    #enters the new listing into the database
    def create
        #if the user does not enter the condition or price fields, reload the page
        if params[:listing][:condition].empty? || params[:listing][:price].empty?
            redirect_to confirm_new_listing_path(card: {id: params[:listing][:card_id]}, empty_search: true)
        else
            whitelisted_params = params.require(:listing).permit(:condition, :price, :card_id)
            current_user.listings.create(whitelisted_params)
            redirect_to(listings_path)
        end
    end

    def edit
        #query to find the correct listing to send to the view
        #eager loading the card associated with the listing
        #then nested eager load the image associated with that card
        @listing = Listing.includes(card: {image_attachment: :blob}).find(params[:id])

        #do not allow access to the edit page of a card that is already purchased
        #instead redirect to listings
        if @listing.purchase
            redirect_to listings_path and return
        end

        @card_image = @listing.card.image

        if current_user.id != @listing.user.id
            redirect_to listings_path
        end
    end

    #called when "Update listing" button is pressed on /listings/:id => listings/show.html.erb
    #updated record for the relevant listing
    def update
        #query to find the correct listing to update
        listing = Listing.find(params[:id])
        
        whitelisted_params = params.require(:listing).permit(:condition, :price)
        listing.update(whitelisted_params)
        redirect_to(listing_path(params[:id]))
    end

    #called when "Delete" button is pressed on /listings/:id => listings/show.html.erb
    #deletes record for the relevant listing
    def delete
        #query to find the correct listing to delete
        Listing.find(params[:id]).destroy
        redirect_to(listings_path)
    end

    private
    #not in use yet
    def set_listing
        @listing = Listing.find(params[:id])
    end
end