class PlayersController < ApplicationController
    before_action :coach_authenticate
    def index
        @players = Players.left_joins(:route_instances).select("players.id, players.name, COALESCE(SUM(route_instances.success),0) as successes, COALESCE(COUNT(*),1) as total, players.number, players.position, players.year")
        .group("players.id, players.name, players.number, players.position, players.year")
    end
    def show
        @player = Players.find(params[:id])
        @route_instances = RouteInstances.where(player_id: params[:id])
        if(@route_instances.length>0)
            @practice_data = RouteInstances.where(player_id: params[:id]).group("practice_id").average("success").transform_values { |v| (v*100).round(2) }
        else
            @practice_data = []
        end
    end
  end
  