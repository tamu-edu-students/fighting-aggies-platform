require 'rails_helper'

RSpec.describe RouteInstance, type: :model do
  describe 'Creating a route_instance' do
    it 'creates a new route_instance with valid attributes' do
      player = Player.create(name: 'John Smith', number: 10, position: 'Center', year: 1)
      route_instance = RouteInstance.new(player_id: player.id, route_name: 'curl', play_name: 'testplay', timestamp_start: 0, timestamp_end: 0, success: 1, practice_id: 1)
      expect(route_instance.save).to be true
      expect(RouteInstance.count).to eq(1)
      expect(RouteInstance.first).to have_attributes(success: 1, player_id: player.id, practice_id: '1')
    end
  end
end
