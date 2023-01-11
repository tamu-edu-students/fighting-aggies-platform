require('capybara/rails')
require 'omniauth'
#extra.id_info.email


Before do 
  def admin_mock
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
              uid: "12345678910",
              info: { 
                  email: "faaplicationmanager@gmail.com",
                  first_name: "Test",
                  last_name: "User"
              },
              credentials: {
                  token: "abcdefgh12345",
                  refresh_token: "12345abcdefgh"
              },
              extra:{
                id_info:{
                  email: "user@gmail.com"
                }
              }
            })
          end
  OmniAuth.config.test_mode = true
  Rails.application.env_config["omniauth.auth"] = admin_mock
end
Given("I am logged in as an administrator") do
  Users.destroy_all
  User.create({:name => 'Test Admin', :role => 'admin', :email => 'user@gmail.com'})
  visit root_path
  click_button "Log In with Google"
end
Given("I am logged in as a coach") do
  Users.destroy_all
  User.create({:name => 'Test Admin', :role => 'coach', :email => 'user@gmail.com'})
  visit root_path
  click_button "Log In with Google"
end
Given("I am logged in as a non-user") do
  Users.destroy_all
  visit root_path
  click_button "Log In with Google"
end
When("I click {string}") do |link|
  click_link link
end
When("I visit the admin page") do
  visit admin_path
end
When("I visit the analytics page") do
  visit dashboard_path
end
Then("I should be on the home screen") do
  expect(page).to have_current_path(root_path)
end
Then("I should be on the analytics dashboard") do
  expect(page).to have_current_path(dashboard_path)
end
Then("I should be on the admin dashboard") do
  expect(page).to have_current_path(admin_path)
end

Then("I should be logged out") do
  expect(session["authenticated"]).to eq(false)
  expect(session["coach"]).to eq(false)
  expect(session["admin"]).to eq(false)
end