class ListingsController < ApplicationController
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

    def show
        @users = User.all
        @listings = Listing.all
        @listing = Listing.find(params[:id])
        @cards = Card.all
    end

    def buy
        @listing = Listing.find(params[:id])
        @cards = Card.all
    end

    def new #called by when getting new.html.erb 'Search' button on /listings/new page
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

    def confirm #called when getting confirm.html.erb, i.e. with 'Yes' button on /listings/new/
        @card = Card.find(params[:card][:id])
    end

    def create #called with 'Create listing' button on /listings/new page
        current_user.listings.create(
            condition: params[:listing][:condition],
            price: params[:listing][:price],
            card_id: params[:listing][:card_id]
        )
        redirect_to(listings_path)
    end

    def update
        Listing.find(params[:id]).update(
            condition: params[:listing][:condition],
            price: params[:listing][:price]
        )
        redirect_to(listing_path(params[:id]))
    end

    def delete
        Listing.find(params[:id]).destroy
        redirect_to(listings_path)
    end
end