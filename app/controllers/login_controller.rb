# frozen_string_literal: true

class LoginController < ApplicationController
  before_action :relog_prevent
  def omniauth
    request_params = request.env['omniauth.auth']
    email = request_params['extra']['id_info']['email'].to_s
    session[:authenticated] = true if User.exists?(email:)
    email = email.gsub('.', '%1F')
    redirect_to(login_path(email), allow_other_host: true)
  end

  def authorize
    email = current_user.email
    session[:authenticated] = true
    email = email.gsub('.', '%1F')
    redirect_to login_path email
  end

  def login
    email = params[:email].gsub('%1F', '.')
    if User.exists?(email:) && !session[:authenticated].blank? && session[:authenticated]
      user = User.find_by_email email
      case user.role
      when 'Admin'
        session[:admin] = true
        redirect_to admin_path
      when 'Coach'
        session[:coach] = true
        redirect_to route_instances_by_player_path
      when 'Data Manager'
        session[:data_manager] = true
        redirect_to practice_videos_path
      end
    else
      flash[:notice] = 'Please login as a valid user.'
      redirect_to root_path
    end
  end

  def relog_prevent
    if session[:coach]
      redirect_to route_instances_by_player_path
    elsif session[:admin]
      redirect_to admin_path
    elsif session[:data_manager]
      redirect_to practice_videos_path
    end
  end
  # def logout
  #   session[:authenticated]=false
  #   session[:coach]=false
  #   session[:admin]=false
  #   redirect_to root_path
  # end
end
