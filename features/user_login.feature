Feature: user login

Scenario: User wants to login with Google
  Given I am on the Login page
	When I click on login with Google
	Then I should be on the Google login page

Scenario: Successful login of a valid user
	Given I am on the Google login page
	When I fill in email with faaplicationuser@gmail.com
	And I click Next
	And I fill in password with password2023
	And I click Login
	Then I should be on the analytics dashboard.

Scenario: Successful login of a valid user
	Given I am on the Google login page
	When I fill in email with faaplicationuser@gmail.com
	And I click Next
	And I fill in password with password2023
	And I click Login
	Then I should be on the analytics dashboard.

Scenario: Successful login as a non role
	Given I am on the Google login page
	When I fill in email with notfaaplicationuser@gmail.com 
	And I click Next
	And I fill in password with password2023
	And I click Login
	Then I should be on the home page.

Scenario: Successful login as an admin
	Given I am on the Google login page
	When I fill in email with faaplicationmanager@gmail.com
	And I click Next
	And I fill in password with password2023
	And I click Login
	Then I should be on the admin page.

Scenario: User chooses not to be logged in
	Given I am on the Google login page
	When I click back
	Then I should be on the home page.
