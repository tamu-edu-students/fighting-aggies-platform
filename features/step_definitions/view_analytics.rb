  Given('player John Smith exists') do
    Player.create(name:"John Smith")
  end

  Given('{string} has run a route') do |string|
    RouteInstance.create(player_id: Player.find_by(name:string).id, success: 1)
  end
  
  Then('I am on the Route Instances Index page') do
    expect(page).to have_current_path(route_instances_index_path)
  end
  
  Then('I am on the Players Index page') do
    expect(page).to have_current_path(players_index_path)
  end
  
  Then('I am on the Show Player page') do
    expect(page).to have_current_path(players_show_path)
  end