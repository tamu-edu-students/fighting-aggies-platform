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
    @players = Player.left_joins(:route_instances).select('players.id, players.name, COALESCE(SUM(route_instances.success),0) as successes, COALESCE(COUNT(*),1) as total, players.number, players.position, players.year')
                     .group('players.id, players.name, players.number, players.position, players.year')
  end

  def show
    @player = Player.find(params[:id])
    @route_instances = RouteInstance.where(player_id: params[:id])
    @practice_data = if @route_instances.length.positive?
                       RouteInstance.where(player_id: params[:id]).group('practice_id').average('success').transform_values { |v| (v * 100).round(2) }
                     else
                       []
                     end
  end
end
