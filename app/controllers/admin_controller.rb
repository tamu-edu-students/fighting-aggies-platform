# frozen_string_literal: true

class AdminController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :admin_authenticate
  def dashboard
    @users = User.order("#{sort_column} #{sort_direction}")
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
