class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :seller_auth_controller?, :seller_user?

  def seller_auth_controller?
    controller_path.start_with?("sellers_auth/")
  end

  def seller_user?
    current_user&.has_role?(:seller)
  end
end