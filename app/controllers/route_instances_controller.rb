class RouteInstancesController < ApplicationController
  before_action :coach_authenticate
  def index
    filters = { player_id: params[:player_id], route_name: params[:route_name], practice_id: params[:practice_id], play_name: params[:play_name] }

    conditions = []
    values = []

    filters.each do |field, value|
      if value.present? && value != '*'
        conditions << "#{field} in (?)"
        values << value
      else
        conditions << "#{field} IS NOT NULL"
      end
    end
    route_instances = RouteInstance.where(conditions.join(' AND '), *values)
    @route_instances = if route_instances.any?
                         route_instances
                       else
                         []
                       end
    total_instances = route_instances.count
    successful_instances = route_instances.where(success: 1).count
    @percent_success = (successful_instances.to_f / total_instances) * 100
  end

  def by_player
    @data = {}
    RouteInstance.all.each do |route_instance|
      player_id = route_instance.player_id
      route_name = route_instance.route_name
      success = route_instance.success

      @data[player_id] = {} if @data[player_id].nil?

      @data[player_id][route_name] = [0, 0] if @data[player_id][route_name].nil?

      @data[player_id][route_name][0] += success
      @data[player_id][route_name][1] += 1
    end
  end
end
