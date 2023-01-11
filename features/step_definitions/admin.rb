Given(/the following users exist/) do |users_table|
  Users.destroy_all
  users_table.hashes.each do |user|
    Users.create user
  end
end

Given('{string} is logged in as an {string}') do |users_name, role|
  user_id = Users.find_by(name: users_name)
  visit(users_path(user_id))
  page.all('#role', text: role)
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
  find('#add_user').click
  sleep(2)
end

Then('they should be taken to the add user page') do
  expect(page).to have_current_path('/users/new')
end

Given('the user is on the add user page') do
  steps %(
    When they click the add user button
    Then they should be taken to the add user page
  )
end

When('they fill in {string} with {string}') do |field, value|
  fill_in(field, with: value)
end

When('press {string}') do |button|
  click_on button
end

Then('{string} should be a {string} should have the email {string}') do |_name, role, _email|
  page.all('#name', text: role)
  page.all('#role', text: role)
  page.all('#email', text: role)
end

Then('I should see {string}') do |message|
  page.all('p', text: message)
end

Then('they should see {string}') do |string|
  expect(page).to have_content(string)
end

When('I go to the edit page for {string}') do |user_name|
  user = Users.find_by name: user_name
  visit edit_user_path(user)
end

When('I fill in {string} with {string}') do |field, input|
  fill_in(field, with: input)
end

When('I press {string}') do |string|
  find('#' + string).click
  sleep(2)
end

Then('I should be on the Admin page') do
  expect(page).to have_current_path(admin_path)
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end

Then('I should see a {string} field called {string}') do |form_type, form_label|
  expect(page).to have_field(form_label, type: form_type)
end

Then('I should be able to select {string} from the {string} select') do |option, label|
  select option, from: label
end

When('they select {string} from the {string} select') do |option, label|
  select option, from: label
end
