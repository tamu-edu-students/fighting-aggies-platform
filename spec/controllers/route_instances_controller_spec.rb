require 'rails_helper'

RSpec.describe RouteInstancesController, type: :controller do
  describe 'GET #index' do
    let!(:player1) { Player.create(name: 'John Doe') }
    let!(:player2) { Player.create(name: 'Jane') }
    let!(:route_instance1) { RouteInstance.create(player_id: player1.id, route_name: 'comeback', play_name: 'zebra 42', practice_id: 2, success: 1) }
    let!(:route_instance2) { RouteInstance.create(player_id: player1.id, route_name: 'curl', play_name: 'curl 12', practice_id: 3, success: 0) }
    let!(:route_instance3) { RouteInstance.create(player_id: player2.id, route_name: 'curl', play_name: 'curl 1', practice_id: 2, success: 0) }
    it 'gets routes based on player id' do
      session[:coach] = true
      get :index, params: { player_id: player1.id, route_name: '*', play_name: '*', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([route_instance1, route_instance2])
    end
    it 'gets routes based on route name' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: 'curl', play_name: '*', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([route_instance2, route_instance3])
    end
    it 'gets routes based on play name' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: '*', play_name: 'curl 12', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([route_instance2])
    end
    it 'gets routes based on practice id' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: '*', play_name: '*', practice_id: 2 }
      expect(assigns(:route_instances)).to eq([route_instance1, route_instance3])
    end
    it 'gets routes based on all parameters' do
      session[:coach] = true
      get :index, params: { player_id: player2.id, route_name: 'curl', play_name: 'curl 1', practice_id: '2' }
      expect(assigns(:route_instances)).to eq([route_instance3])
    end
    it 'returns an empty array when no routes available' do
      session[:coach] = true
      get :index, params: { player_id: 9, route_name: 'blah', play_name: '*', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([])
    end
    it 'calculates the proper success rate' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: '*', play_name: '*', practice_id: '*' }
      expect(assigns(:percent_success)).to eq(1.0 / 3 * 100)
    end
  end

  describe 'GET #by_player' do
    let!(:player1) { Player.create(name: 'John Doe', id: 0) }
    let!(:player2) { Player.create(name: 'Jane', id: 1) }
    let!(:route_instance1) { RouteInstance.create(player_id: player1.id, route_name: 'curl', play_name: 'zebra 42', practice_id: 2, success: 1) }
    let!(:route_instance2) { RouteInstance.create(player_id: player1.id, route_name: 'curl', play_name: 'curl 12', practice_id: 3, success: 0) }
    let!(:route_instance3) { RouteInstance.create(player_id: player2.id, route_name: 'curl', play_name: 'curl 1', practice_id: 2, success: 0) }
    it 'populates the array with successes and totals' do
      session[:coach] = true
      get :by_player
      expect(assigns(:data)).to eq({ 0 => { 'curl' => [1, 2] }, 1 => { 'curl' => [0, 1] } })
    end
  end
end
