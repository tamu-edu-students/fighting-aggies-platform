Feature: admin
  Scenario: admin navigates to add user
    Given "Eli Tracy" is logged in as an "admin"
    Given user is on the "admin" dashboard 
    When they click the add user button
    Then they should be taken to the add user page

  Scenario: admin adds user
    Given "Eli Tracy" is logged in as an "admin"
    Given the user is on the add user page
    When they fill in "Name" with "John Doe"
    And they fill in "Role" with "Coach"
    And they fill in "Email" with "johndoe@example.com"
    And press "Create User"
    Then "John Doe" should be a "Coach" should have the email "johndoe@example.com"
    And I should see "User was successfully created."
