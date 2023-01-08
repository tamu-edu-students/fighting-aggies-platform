Given('I am on the Login page') do
  visit root_path
end

When('I click on login with Google') do
  
end

Then('I should be on the Google login page') do
  #expect(page).to have_content(URI.parse(current_url).to_s)
  @session.expect(page).to has_content("Sign in with Google")
end
