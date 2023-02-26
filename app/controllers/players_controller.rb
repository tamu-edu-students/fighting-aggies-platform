class PlayersController < ApplicationController
  before_action :coach_authenticate
  def index
    @players = Player.left_joins(:route_instances).select('players.id, players.name, COALESCE(SUM(route_instances.success),0) as successes, COALESCE(COUNT(*),1) as total, players.number, players.position, players.year')
                     .group('players.id, players.name, players.number, players.position, players.year')
  end

  def show
    @player = Player.find(params[:id])
    @route_instances = @player.route_instances
    @overall_success_rate = @player.route_instances.average(:success)
    @success_by_route = @player.route_instances.group(:route_name).average(:success)

    # Success Rates by Practice ID
    practice_ids = @route_instances.distinct.pluck(:practice_id).sort.map(&:to_i)
    @success_rates = practice_ids.map do |practice_id|
      successes = @route_instances.where(practice_id:, success: true).count
      attempts = @route_instances.where(practice_id:).count
      success_rate = attempts.positive? ? successes.fdiv(attempts) * 100 : 0
      { practice_id:, success_rate: }
    end
    @success_rates = @success_rates.sort_by { |sr| sr[:practice_id] }
  end
end
