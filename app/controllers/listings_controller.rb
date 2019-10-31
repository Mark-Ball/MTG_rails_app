class ListingsController < ApplicationController
    def index
        @listing
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
        @card = Card.new

        if params[:card][:set].empty? 
            @cards = Card.where(name: params[:card][:name])
        else
            @cards = Card.where(name: params[:card][:name]).where(set: params[:card][:set])
        end
    end

    def create
    end
end