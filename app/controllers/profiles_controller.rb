class ProfilesController < ApplicationController
    before_action :authenticate_user!
    
    def show
        @user = current_user
        @address = Address.where(user_id: current_user.id)[0]
    end
end