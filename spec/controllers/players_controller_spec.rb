require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  describe 'GET #index' do
    let!(:player1) { Player.create(name: 'John Doe', number: 1, position: 'QB', year: 'F') }
    let!(:player2) { Player.create(name: 'Jane Doe', number: 2, position: 'QB', year: 'F') }
    let!(:route_instance1) { RouteInstance.create(player_id: player1.id, route_name: 'route1', success: 1) }
    let!(:route_instance2) { RouteInstance.create(player_id: player1.id, route_name: 'route1', success: 0) }
    it 'lists all existing users' do
      session[:coach] = true
      get :index
      expect(assigns(:players)).to include(player1)
      expect(assigns(:players)).to include(player2)
    end
  end
  describe '#show' do
    let!(:player) { Player.create(name: 'John Doe', number: 1, position: 'QB', year: 'F') }
    let!(:route_instance1) { RouteInstance.create(player_id: player.id, route_name: 'route1', success: 1, practice_id: 11) }
    let!(:route_instance2) { RouteInstance.create(player_id: player.id, route_name: 'route2', success: 0, practice_id: 17) }
    it 'assigns the correct player' do
      session[:coach] = true
      get :show, params: { id: player.id }
      expect(assigns(:player)).to eq(player)
    end

    it 'assigns the correct route instances for the player' do
      session[:coach] = true
      get :show, params: { id: player.id }
      expect(assigns(:route_instances)).to match_array([route_instance1, route_instance2])
    end

    it 'assigns the correct overall success rate for the player' do
      session[:coach] = true
      get :show, params: { id: player.id }
      expect(assigns(:overall_success_rate)).to eq(0.5)
    end

    it 'assigns the correct success rate by route for the player' do
      session[:coach] = true
      get :show, params: { id: player.id }
      expect(assigns(:success_by_route)).to eq({ route_instance1.route_name => 1.0, route_instance2.route_name => 0.0 })
    end

    it 'assigns the correct success rates by practice id for the player' do
      session[:coach] = true
      get :show, params: { id: player.id }
      expect(assigns(:success_rates)).to match_array([
                                                       { practice_id: route_instance1.practice_id.to_i, success_rate: 100.0 },
                                                       { practice_id: route_instance2.practice_id.to_i, success_rate: 0.0 }
                                                     ])
    end
  end
end
