class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception
   before_filter :authenticate_user!
   before_action :configure_permitted_parameters, if: :devise_controller?
   #load_and_authorize_resource :unless => :devise_controller? 
   #check_authorization :unless => :devise_controller?
   #before_filter {|controller| controller.instance_variable_set(:@_authorized, true) if controller.devise_controller? }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def authenticate_admin_user!
    raise SecurityError unless current_user.is_admin 
  end

  rescue_from SecurityError do |exception|
    redirect_to root_path , flash: {alert: "Access Denied"}
  end

  def after_sign_in_path_for(resource)
    #paypal_return_path
    if resource.is_admin?
        admin_dashboard_path
    else
        root_path
    end
  end

  def access_denied(exception)
    redirect_to root_path, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

