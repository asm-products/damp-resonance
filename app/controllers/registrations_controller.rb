class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?
  

  
  def update_sanitized_params
   devise_parameter_sanitizer.for(:sign_up) do |u| 
    u.permit(:name, :email, :password, :password_confirmation, :address, :city, :state, :zip, :longitude, :latitude, :facebook_uid, :provider)
   end
    
   devise_parameter_sanitizer.for(:account_update) do |u| 
    u.permit(:name, :email, :password, :password_confirmation, :current_password, :address, :city, :state, :zip, :longitude, :latitude, :facebook_uid, :provider)
    end
   end
 
  def update_resource(resource, params)
    if current_user.provider == "facebook"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end


end
