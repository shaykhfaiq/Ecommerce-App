module Dashboard
  class SellerProfilesController < ApplicationController
    layout "seller_layout"
    before_action :set_profile

    def show; end

    def edit; end

    def update
      if @profile.update(seller_profile_params)
        redirect_to dashboard_seller_profile_path, notice: "Profile updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_profile
      @profile = current_user.seller_profile

      # If profile doesn't exist, create one with default status
      unless @profile
        @profile = current_user.create_seller_profile(status: :active)
      end
    end

    def seller_profile_params
      params.require(:seller_profile).permit(
        :store_name, :business_email, :phone_number, :address,
        :city, :state, :country, :postal_code, :description,
        :website, :tax_id, :logo_url, :logo
      )
    end
  end
end
