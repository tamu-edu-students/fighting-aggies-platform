class RouteInstancesController < ApplicationController

  def index
    @route_instances = RouteInstances.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /RouteInstances/1 or /RouteInstances/1.json
  def show
    id = params[:id]
    @route_instance = RouteInstances.find(id)
  end

end
