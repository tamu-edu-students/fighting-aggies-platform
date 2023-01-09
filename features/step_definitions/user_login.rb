Given("I am logged in as an administrator") do
  User.create({:name => 'Test Admin', :role => 'admin', :email => 'faaplicationmanager@gmail.com'}) 
  visit login_path(email: "faaplicationmanager@gmail.com".gsub(".","%1F"))
end
Given("I am logged in as a coach") do
  User.create({:name => 'Test User', :role => 'coach', :email => 'faaplicationuser@gmail.com'}) 
  visit login_path(email: "faaplicationuser@gmail.com".gsub(".","%1F"))
end
Given("I am logged in as a non-user") do
  visit login_path(email: "notfaaplicationuser@gmail.com".gsub(".","%1F"))
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