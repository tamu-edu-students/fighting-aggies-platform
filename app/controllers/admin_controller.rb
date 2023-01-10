class AdminController < ApplicationController
  # before_action :require_user
  def dashboard
    @users = User.all
  end
end
