class ListingsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    #called when user clicks "Browse" in the top bar
    #sends data to listings/index.html.erb
    def index
        @cards = Card.all

        #create the array of ids for listings still available (calculated as all listings minus sold listings)
        listings_available = Listing.all.ids - Purchase.all.map { |i| i.listing_id }

        search = "%#{params[:search]}%"

        #send the view only the available listings and only unique cards to render
        if params[:search]
            @listings = Listing.where(card_id: Card.where("name LIKE ?", search).ids).uniq { |l| l.card_id }
        else #show all available
            @listings = Listing.where(id: listings_available).uniq { |l| l.card_id }
        end
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
        @listing = Listing.find(params[:id])
        @card_image = Card.find(@listing.card_id).image
    end

    #called when "Update listing" button is pressed on /listings/:id => listings/show.html.erb
    #updated record for the relevant listing
    def update
        whitelisted_params = params.require(:listing).permit(:condition, :price)
        Listing.find(params[:id]).update(whitelisted_params)
        #     condition: params[:listing][:condition],
        #     price: params[:listing][:price]
        # )
        redirect_to(listing_path(params[:id]))
    end

    #called when "Delete" button is pressed on /listings/:id => listings/show.html.erb
    #deletes record for the relevant listing
    def delete
        Listing.find(params[:id]).destroy
        redirect_to(listings_path)
    end

    private
    #not in use yet
    def set_listing
        @listing = Listing.find(params[:id])
    end
end