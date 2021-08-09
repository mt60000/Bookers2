class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id)

  end

  def after_sign_up_path_for(resource)
    user_path(current_user.id)

  end

  def unless_user_signed_in
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
