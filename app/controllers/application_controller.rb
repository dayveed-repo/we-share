class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :update_allowed_parameters, if: :devise_controller?
  
    protected
  
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password)}
    end

    
  def check_followers
    if User.find(params[:id]).followers.where(follower_id: current_user.id) == []
      @inner_text = 'follow'
    else
      @inner_text = 'unfollow'
    end

    return @inner_text
  end
end
