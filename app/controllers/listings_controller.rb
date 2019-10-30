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

    def buy
        @listing = Listing.find(params[:id])
        @cards = Card.all
    end

    def new
        @card = Card.where(name: params[:name]).where(set: params[:set])[0]
        # where(name: params[:name]).where(set: params[:set])
        # find_by_id(params[:id])
    end

    def create
    end
end