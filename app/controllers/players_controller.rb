class PlayersController < ApplicationController
    def index
        @players = RouteInstances.joins(:player).select("players.id, players.name, SUM(route_instances.success) as successes, COUNT(*) as total, players.number, players.position, players.year")
        .group("players.id, players.name, players.number, players.position, players.year")
    end
    def show
        @player = Players.find(params[:id])
        @route_instances = RouteInstances.where(player_id: params[:id])
        @practice_data = RouteInstances.where(player_id: params[:id]).group("practice_id").average("success").transform_values { |v| (v*100).round(2) }
    end
  end
  