Feature: user login

Scenario: Successful login of a valid user
	Given I am logged in as an administrator
	Then I should be on the admin dashboard

Scenario: Successful login of a valid user
	Given I am logged in as a coach
	Then I should be on the analytics dashboard

Scenario: Successful login as a non role
	Given I am logged in as a non-user
	Then I should be on the home screen

Scenario: Log out successfully as an admin
  	Given I am logged in as a coach
  	When I click "Log Out"
  	Then I should be on the home screen
  	When I visit the admin page
	Then I should be on the home screen
	When I visit the analytics page
	Then I should be on the home screen

Scenario: Log out successfully
  	Given I am logged in as an administrator
  	When I click "Log Out"
  	Then I should be on the home screen
  	When I visit the admin page
	Then I should be on the home screen
	When I visit the analytics page
	Then I should be on the home screen