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

        if current_user.address.nil?
            current.user.create_address(
                address: params[:address][:address],
                suburb: params[:address][:suburb],
                city: params[:address][:city],
                country: params[:address][:country],
                postcode: params[:address][:postcode]
            )
        else
            current_user.address.update(
                address: params[:address][:address],
                suburb: params[:address][:suburb],
                city: params[:address][:city],
                country: params[:address][:country],
                postcode: params[:address][:postcode] 
            )
        end
    end
end