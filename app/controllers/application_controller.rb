class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers 

  def admin_authenticate
    if session[:coach]
      redirect_to dashboard_path
    elsif session[:admin].blank? || !session[:admin]
      redirect_to root_path
      flash[:notice] = "Please login as an administrator. V2"
    end
  end

  def coach_authenticate
    if session[:admin]
      redirect_to admin_path
    elsif session[:coach].blank? || !session[:coach]
      redirect_to root_path
      flash[:notice] = "Please login as a coach. V2"
    end
  end
end
