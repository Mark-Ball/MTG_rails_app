class ProfilesController < ApplicationController
    before_action :authenticate_user!
    
    def show
        @user = current_user
        @address = Address.where(user_id: current_user.id)[0]
    end

    def edit
        @user = current_user
    end

    def update
        current_user.update(
            name: params[:profile][:name],
            alias: params[:profile][:alias],
            email: params[:profile][:email]
        )

        byebug
    end
end