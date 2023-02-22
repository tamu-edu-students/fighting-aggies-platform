Feature: user login

Scenario: Successful login of a valid user
	Given the database has been reset
	Given I am logged in as an administrator
	Then I should be on the admin dashboard

Scenario: Successful login of a valid user
	Given the database has been reset
	Given I am logged in as a coach
	Then I should be on the analytics dashboard

Scenario: Successful login as a non role
	Given the database has been reset
	Given I am logged in as a non-user
	Then I should be on the home screen

Scenario: Log out successfully as an admin
	Given the database has been reset
  	Given I am logged in as a coach
  	When I click "Log Out"
  	Then I should be on the home screen
  	When I visit the admin page
	Then I should be on the home screen
	When I visit the analytics page
	Then I should be on the home screen

Scenario: Log out successfully
	Given the database has been reset
  	Given I am logged in as an administrator
  	When I click "Log Out"
  	Then I should be on the home screen
  	When I visit the admin page
	Then I should be on the home screen
	When I visit the analytics page
	Then I should be on the home screen

Scenario: Logged in as Coach navigate to home
	Given the database has been reset
	Given I am logged in as a coach
	Then I should be on the analytics dashboard
	When I visit the home page
	Then I should be on the analytics dashboard
	When I visit the admin page
	Then I should be on the analytics dashboard

Scenario: Logged in as admin navigate to home
	Given the database has been reset
	Given I am logged in as an administrator
	Then I should be on the admin dashboard
	When I visit the home page
	Then I should be on the admin dashboard
	When I visit the analytics page
	Then I should be on the admin dashboard

Scenario: Logged in as data manager navigate to home
	Given the database has been reset
	Given I am logged in as a data manager
	Then I should be on the data manager dashboard
	When I visit the home page
	Then I should be on the data manager dashboard
	When I visit the analytics page
	Then I should be on the data manager dashboard