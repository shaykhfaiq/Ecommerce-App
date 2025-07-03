class SellersAuth::SessionsController < Devise::SessionsController
  layout "application"

  # Called after successful login
  def create
    super
  end

  # Called after logout
  def destroy
    super
  end

  protected

  # Redirect to seller dashboard after login
  def after_sign_in_path_for(resource)
    if resource.has_role?(:seller)
      Rails.logger.info "✅ Seller signed in: #{resource.full_name}"
      puts "✅ Seller signed in: #{resource.full_name}" # Console output (dev only)
      dashboard_seller_dashboard_path
    else
      sign_out(resource)
      flash[:alert] = "Access denied. You are not authorized as a seller."
      sellers_auth_login_path
    end
  end

  # Redirect to login page after logout
  def after_sign_out_path_for(resource_or_scope)
    sellers_auth_login_path
  end
end
