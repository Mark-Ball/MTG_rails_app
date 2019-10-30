class ListingsController < ApplicationController
    def index
        @listings = Listing.all.uniq { |listing| listing.card_id }
        @cards = Card.all
    end

    def show
        @users = User.all
        @listings = Listing.all
        @listing = Listing.find(params[:id])
        @cards = Card.all
    end
end