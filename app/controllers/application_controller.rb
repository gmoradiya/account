class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def check_admin_role
    redirect_to root_path, notice: 'You are not allowed' if !['admin', 'super_admin'].include?(current_user.role)
  end

  def check_admin_staff_role
    redirect_to root_path, notice: 'You are not allowed' if !['admin', 'super_admin', 'staff'].include?(current_user.role)
  end
end
