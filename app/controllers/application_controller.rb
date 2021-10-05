class ApplicationController < ActionController::Base
  before_action :authenticate_user! 
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected 

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(
      :account_update, keys: [:name, :last_name, :avatar])
    
  end
  
  def get_recent_notifications
    @recent_notifications = current_user.notifications.all.order("created_at desc").limit(5)
  end
end
