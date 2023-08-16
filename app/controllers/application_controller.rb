class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_unchecked_notifications, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    lyrics_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [user_profile_attributes: [:id, :name, :icon, :image_cache, :introduction]])
    devise_parameter_sanitizer.permit(:account_update, keys: [user_profile_attributes: [:id, :name, :icon, :image_cache, :introduction]])
  end

  private

  def set_unchecked_notifications
    @unchecked_notifications = unchecked_notifications
  end

  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end
end
