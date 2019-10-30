class TestController < ApplicationController
    def show
        @card = Card.find(102)
    end
end