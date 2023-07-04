class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def authenticate_user!
    if user_signed_in?
      super
    elsif [welcome_path, new_user_session_path, new_user_registration_path].exclude?(request.original_fullpath)
      redirect_to welcome_path, notice: 'You need to sign in or sign up before continuing.'
    end
  end
end
