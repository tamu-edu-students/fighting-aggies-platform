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
