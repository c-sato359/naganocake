class ApplicationController < ActionController::Base
	#before_action :authenticate_customer!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?
   protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    if customer_signed_in?
      root_path#(current_customer.id)
    else
      new_customer_session_path
    end
  end

  def after_sign_out_path_for(resource)
    if resouse == :admin
      admin_session_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :email])
  end
end
