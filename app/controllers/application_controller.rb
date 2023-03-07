class ApplicationController < ActionController::Base
	#before_action :authenticate_customer!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :exception

  protected

  #def after_sign_in_path_for(resource)
  #  if customer_signed_in?
   #  item_path(current_customer.id)
    #else
     # new_customer_session_path
  #  end
#  end

#  def after_sign_out_path_for(resource)
 #   if resouse == :admin
  #    admin_session_path
   # else
    #  new_customer_session_path
#    end
#  end
def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
       admin_homes_top_path
    else
       public_customers_path
    end
end
def
after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        public_homes_top_path
    end
end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :telephon_number, :postal_code, :address])
  end
end
  
