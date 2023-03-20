class PlayersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :coach_authenticate

  def sort_column
    Player.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def index
    @players = Player.left_joins(:route_instances)
                 .select('players.id, players.name, COALESCE(SUM(route_instances.success),0) as successes, COALESCE(COUNT(*),1) as total, players.number, players.position, players.year')
                 .group('players.id, players.name, players.number, players.position, players.year')
  end

  def show
    if params[:start_date].present? && params[:end_date].present?
      @start_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])
    else
      @start_date=RouteInstance.distinct.pluck(:date).min()
      @end_date=RouteInstance.distinct.pluck(:date).max()
    end
    if params[:routes].present?
      @routes=params[:routes].split(",")
    else
      @routes=[]
    end
    if params[:route].present?
      route=params[:route]
      if @routes.include?(route)
        @routes.delete(route)
      else
        @routes.push(route)
      end
    end
    @player = Player.find(params[:id])
    @route_instances = @player.route_instances.where('date >= ?', @start_date).where('date <= ?', @end_date)
    @overall_success_rate = @player.route_instances.average(:success)
    @success_by_route = @player.route_instances.group(:route_name).average(:success)
    @all_routes = RouteInstance.pluck(:route_name).uniq
    @routePracticeIds = RouteInstance.pluck(:practice_id).uniq.map(&:to_i).sort
    chart_data = RouteInstance.where(player_id: params[:id]).group(:route_name, :practice_id).average(:success).sort_by { |(route_name, practice_id), _| [route_name, practice_id.to_i] }
    @dataByRoute = {}
    @all_routes.each do |name|
      @dataByRoute[name] = Array.new(@routePracticeIds.length, 0)
    end
    chart_data.each do |instance|
      @dataByRoute[instance[0][0]][instance[0][1].to_i-1]=instance[1]*100
    end
    @all_routes=RouteInstance.distinct.pluck(:route_name)
    

end
end
