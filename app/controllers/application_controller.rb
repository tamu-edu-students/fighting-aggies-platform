# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers

  helper_method :current_user

  def admin_authenticate
    return if session[:admin]

    flash[:notice] = 'Please login as an administrator.'
    redirect_to root_path
  end

  def coach_authenticate
    return if session[:coach]

    flash[:notice] = 'Please login as a coach.'
    redirect_to root_path
  end

  def data_manager_authenticate
    return if session[:data_manager]

    flash[:notice] = 'Please login as a data manager.'
    redirect_to root_path
  end

  def logout
    session[:authenticated] = false
    session[:coach] = false
    session[:admin] = false
    redirect_to root_path
  end

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end
end
