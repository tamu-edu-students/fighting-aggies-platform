require 'rails_helper'

RSpec.describe RouteInstancesController, type: :controller do
  describe "GET #index" do
    before do
      @route_instance_1 = RouteInstance.create(player_id: 1, route_name: 'Route A', practice_id: 1, play_name: 'Play A', success: 1)
      @route_instance_2 = RouteInstance.create(player_id: 2, route_name: 'Route B', practice_id: 2, play_name: 'Play B', success: 0)
      @route_instance_3 = RouteInstance.create(player_id: 3, route_name: 'Route C', practice_id: 3, play_name: 'Play C', success: 1)
      session[:authenticated] = true
      session[:coach] = true
    end
    it "assigns the correct RouteInstance objects based on the filters" do
      get :index, params: { player_id: 1, route_name: 'Route A', practice_id: 1, play_name: 'Play A' }
      expect(assigns(:route_instances)).to eq([@route_instance_1])
  
      get :index, params: { player_id: 2 }
      expect(assigns(:route_instances)).to eq([@route_instance_2])
    end
  
    it "calculates the correct success rate for the filtered RouteInstance objects" do
      get :index, params: { player_id: 1, route_name: 'Route A', practice_id: 1, play_name: 'Play A' }
      expect(assigns(:percent_success)).to eq(100.0)
  
      get :index, params: { player_id: 2 }
      expect(assigns(:percent_success)).to eq(0.0)
    end
  end

  describe "GET #by_player" do
    @route_instance_1 = RouteInstance.create({player_id: 1, route_name: 'Route A', success: 1}) 
    @route_instance_2 = RouteInstance.create({player_id: 1, route_name: 'Route A', success: 1}) 
    @route_instance_3 = RouteInstance.create({player_id: 1, route_name: 'Route B', success: 0}) 
    @route_instance_4 = RouteInstance.create({player_id: 2, route_name: 'Route A', success: 1}) 
  
    it "calculates the success rate for each player and route combination" do
      get :by_player
      expect(assigns(:data)).to eq({
        1 => { 'Route A' => [2, 2], 'Route B' => [0, 1] },
        2 => { 'Route A' => [1, 1] }
      })
    end
  end
end
