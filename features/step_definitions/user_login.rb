Given("I am logged in as an administrator") do
  visit login_path(email: "faaplicationmanager@gmail.com")
end
Given("I am logged in as a coach") do
  visit login_path(email: "faaplicationuser@gmail.com")
end
Given("I am logged in as a non-user") do
  visit login_path(email: "notfaaplicationuser@gmail.com")
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