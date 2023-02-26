require 'rails_helper'

RSpec.describe Player, type: :model do
  before(:each) do
    ActiveRecord::Base.connection.execute("DELETE FROM players")
  end
  describe 'Creating a player' do
    it 'creates a new player with valid attributes' do
      player = Player.new(name: 'John Smith', number: 10, position: 'Center', year: 'F')
      expect(player.save).to be true
      expect(Player.count).to eq(1)
      expect(Player.first).to have_attributes(name: 'John Smith', number: 10, position: 'Center', year: 'F')
    end
  end
end
