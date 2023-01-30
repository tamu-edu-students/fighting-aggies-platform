require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  describe "GET #index" do
    before do
      players = []
      3.times { players << Player.create(name: "Player #{rand(1..1000)}", number: rand(1..100), position: "Position #{rand(1..5)}", year: rand(1..4)) }
      5.times { RouteInstance.create(success: [true, false].sample, player: players.sample) }
      session[:authenticated] = true
      session[:coach] = true
    end

    it "populates an array of players with player data" do
      get :index
      expect(assigns(:players)).to be_an(ActiveRecord::Relation)
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before do
      @player = Player.create(name: "Player #{rand(1..1000)}", number: rand(1..100), position: "Position #{rand(1..5)}", year: rand(1..4))
      @route_instances = []
      5.times { @route_instances << RouteInstance.create(success: [true, false].sample, player: @player) }
      session[:authenticated] = true
      session[:coach] = true
    end

    it "assigns the requested player to @player" do
      get :show, params: { id: @player.id }
      expect(assigns(:player)).to eq @player
    end

    it "assigns route instances of the player to @route_instances" do
      get :show, params: { id: @player.id }
      expect(assigns(:route_instances)).to match_array(@route_instances)
    end

    it "assigns practice data of the player to @practice_data" do
      get :show, params: { id: @player.id }
      expect(assigns(:practice_data)).to be_a(Hash)
    end

    it "renders the :show template" do
      get :show, params: { id: @player.id }
      expect(response).to render_template :show
    end
  end
end
