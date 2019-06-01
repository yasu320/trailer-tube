class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :username, :password, :password_confirmation]
    account_update = [:email, :username, :password, :password_confirmation, :image, :description, :birth_date, :sex, :website]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: account_update
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
