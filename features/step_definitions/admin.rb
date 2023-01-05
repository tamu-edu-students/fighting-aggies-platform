Given('{string} is logged in as an {string}') do |users_name, role|
  user_id = Users.find_by(name: users_name)
  visit(users_path(user_id))
  page.all('div p #role', text: role)
  visit(admin_path)
  sleep(1)
end

Given('user is on the {string} dashboard') do |role|
  if role == 'admin'
    expect(page).to have_current_path(admin_path)
  else
    pending
  end
end

When('they click the add user button') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('they should be taken to the add user page') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('the user is logged in as an admin') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('the user is on the add user page') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('they fill in {string} with {string}') do |_string, _string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When('press {string}') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('{string} should be a {string} should have the email {string}') do |_string, _string2, _string3|
  pending # Write code here that turns the phrase above into concrete actions
end
