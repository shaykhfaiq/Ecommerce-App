# app/controllers/sellers_auth/registrations_controller.rb
class SellersAuth::RegistrationsController < Devise::RegistrationsController
  layout "application"

  # Explicitly tell Devise which resource we're using
  def resource_name
    :user
  end

  def resource_class
    User
  end

  def new
    build_resource
    @user = resource
    @user.build_seller_profile
    respond_with resource
  end

  def create
    build_resource(sign_up_params)

    # Set full name
    resource.full_name = "#{params[:user][:first_name]} #{params[:user][:last_name]}"

    if resource.save
      resource.add_role(:seller)
      resource.create_seller_profile(
        business_email: params[:user][:business_email],
        phone_number: params[:user][:phone_number],
        store_name: "#{resource.full_name}'s Store",
        store_slug: resource.full_name.parameterize
      )
      sign_up(resource_name, resource)
      redirect_to dashboard_seller_root_path, notice: "Welcome, #{resource.full_name}!"
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name, 
      :last_name, 
      :business_email, 
      :phone_number
    ])
  end

  def after_sign_up_path_for(resource)
    dashboard_seller_root_path
  end
end