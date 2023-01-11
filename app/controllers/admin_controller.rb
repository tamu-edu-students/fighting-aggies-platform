class AdminController < ApplicationController
  # before_action :require_user
  def dashboard
    @users = User.all
    if session[:admin].blank? || !session[:admin]
      redirect_to root_path
      flash[:notice] = "Please login as an administrator."
    end
  end
end
