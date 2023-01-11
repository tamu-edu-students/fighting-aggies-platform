class PagesController < ApplicationController
  def home
    if session[:coach].blank? || !session[:coach]
      redirect_to root_path
      flash[:notice] = "Please login as a coach."
    end
  end
end
