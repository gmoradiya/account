# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  protected

  # Allow users to update their password without providing the current password
  def update_resource(resource, params)
    if params[:password].present?
      resource.update_without_password(params)
    else
      resource.update(params)
    end
  end
end
