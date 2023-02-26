Given('player {string} exists') do |string|
  Player.create(name: string)
end

Given('{string} has run a route') do |string|
  RouteInstance.create(player_id: Player.find_by(name: string).id, success: 0)
end

Then('I am on the Route Instances Index page') do
  expect(page).to have_current_path("#{route_instances_path}/*/*/*/*")
end

Then('I am on the Players Index page') do
  expect(page).to have_current_path(players_index_path)
end

Then('I am on the By Player page') do
  expect(page).to have_current_path(route_instances_by_player_path)
end

Then('I am on the Player Show page for {string}') do |string|
  expect(page).to have_current_path(players_show_path(Player.find_by(name: string).id))
end
