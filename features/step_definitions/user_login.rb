# frozen_string_literal: true

require('capybara/rails')
require 'omniauth'
require 'csv'
# extra.id_info.email

Before do
  def admin_mock
    OmniAuth.config.mock_auth[:google_oauth2] =
      OmniAuth::AuthHash.new({
                               provider: 'google_oauth2',
                               uid: '12345678910',
                               info: {
                                 email: 'faaplicationmanager@gmail.com',
                                 first_name: 'Test',
                                 last_name: 'User'
                               },
                               credentials: {
                                 token: 'abcdefgh12345',
                                 refresh_token: '12345abcdefgh'
                               },
                               extra: {
                                 id_info: {
                                   email: 'user@gmail.com'
                                 }
                               }
                             })
  end
  OmniAuth.config.test_mode = true
  Rails.application.env_config['omniauth.auth'] = admin_mock
end
Given('the database has been reset') do
  User.destroy_all
  Player.destroy_all
  RouteInstance.destroy_all
end
Given('I am logged in as an administrator') do
  User.create({ name: 'Test Admin', role: 'Admin', email: 'user@gmail.com' })
  visit root_path
  click_button 'Log In with Google'
end
Given('I am logged in as a coach') do
  User.create({ name: 'Test Admin', role: 'Coach', email: 'user@gmail.com' })
  visit root_path
  click_button 'Log In with Google'
end
Given('I am logged in as a data manager') do
  CSV.foreach('db/seeds/players.csv', headers: true) do |row|
    Player.create!(row.to_hash)
  end
  User.create({ name: 'Test Data Manager', role: 'Data Manager', email: 'user@gmail.com' })
  visit root_path
  click_button 'Log In with Google'
end
Given('I am logged in as a non-user') do
  visit root_path
  click_button 'Log In with Google'
end
When('I click {string}') do |link|
  click_link link
end
When('I visit the admin page') do
  visit admin_path
end
When('I visit the analytics page') do
  visit dashboard_path
end
When('I visit the home page') do
  visit root_path
end
Then('I should be on the home screen') do
  expect(page).to have_current_path(root_path)
end
Then('I should be on the analytics dashboard') do
  expect(page).to have_current_path(route_instances_by_player_path)
end
Then('I should be on the admin dashboard') do
  expect(page).to have_current_path(admin_path)
end
Then('I should be on the data manager dashboard') do
  expect(page).to have_current_path(practice_videos_path)
end
