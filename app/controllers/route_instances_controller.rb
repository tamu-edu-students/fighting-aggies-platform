class RouteInstancesController < ApplicationController
  before_action :coach_authenticate

  def index
    @route_instances = RouteInstances.paginate(:page => params[:page], :per_page => 20)
  end
end
