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

    def create
    end
end