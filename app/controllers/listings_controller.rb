class ListingsController < ApplicationController
    
    #called when user clicks "Browse" in the top bar
    #sends data to listings/index.html.erb
    def index
        @listing
        @listings = Listing.all.uniq { |listing| listing.card_id }
        @cards = Card.all

        @card_types = ['Artifact', 'Creature', 'Enchantment', 'Instant', 'Land', 'Sorcery']
        @rarities = Card.distinct.pluck(:rarity).sort
        # [['Mythic', 1], ['Rare', 2], ['Uncommon', 3], ['Common', 4]]
        @conditions = ['Any', 'Mint', 'Near mint', 'Excellent', 'Good', 'Lightly played', 'Played', 'Poor']
        @sets = Card.distinct.pluck(:set).sort
    end

    #called when user clicks a card on listings/index.html.erb
    #sends data to listings/show.html.erb
    def show
        @users = User.all
        @listing = Listing.find(params[:id])
        @listings = Listing.where(card_id: @listing.card_id)
        @card = Card.find(@listing.card_id)
    end

    #called when user clicks "Buy" on the show page
    #sends data to listings/buy.html.erb. 
    def buy 
        @listing = Listing.find(params[:id])
        @card_image = Card.find(@listing.card_id).image
        card_name = Card.find(@listing.card_id).name

        session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
                name: card_name,
                amount: @listing.price,
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

    #called when user clicks "Confirm" on listings/id/buy page => listings/buy.html.erb
    #creates records in database
    def confirm_buy
        # current_user.purchases.create(
        #     listing_id: params[:id],
        #     purchase_id: 1234,
        # )
        # redirect_to(listings_path)
    end

    #called when user clicks "Search" on listings/new.html.erb
    #sends data to listings/new.html.erb
    def new 
        @card = Card.new

        if params[:card].nil?
            @cards = nil
        else
            if params[:card][:set].empty? 
                @cards = Card.where(name: params[:card][:name])
            else
                @cards = Card.where(name: params[:card][:name]).where(set: params[:card][:set])
            end
        end
    end

    #called when user clicks "Yes" button on listings/new => new.html.erb
    #sends data to listings/confirm.html.erb
    def confirm_new 
        @card = Card.find(params[:card][:id])
    end

    #called with "Create listing" button on /listings/new/confirm => confirm.html.erb
    #enters the new listing into the database
    def create
        current_user.listings.create(
            condition: params[:listing][:condition],
            price: params[:listing][:price],
            card_id: params[:listing][:card_id]
        )
        redirect_to(listings_path)
    end

    #called when "Update listing" button is pressed on /listings/:id => listings/show.html.erb
    #updated record for the relevant listing
    def update
        Listing.find(params[:id]).update(
            condition: params[:listing][:condition],
            price: params[:listing][:price]
        )
        redirect_to(listing_path(params[:id]))
    end

    #called when "Delete" button is pressed on /listings/:id => listings/show.html.erb
    #deletes record for the relevant listing
    def delete
        Listing.find(params[:id]).destroy
        redirect_to(listings_path)
    end
end