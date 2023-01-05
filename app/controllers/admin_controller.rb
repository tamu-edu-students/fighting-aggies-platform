class AdminController < ApplicationController
  def dashboard
    @users = Users.all
  end
end
