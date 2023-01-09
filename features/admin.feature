Feature: admin
  Background: users in database

    Given the following users exist:
    | name                | role      | email             |
    | Tuong Tran          | admin     | t2tran@t2tran.edu |
    | Boaty McBoatFace    | Coach     | BoatyMBF@gmail.com|
  
  @admin
  Scenario: admin navigates to add user
    Given "Eli Tracy" is logged in as an "admin"
    Given user is on the "admin" dashboard 
    When they click the add user button
    Then they should be taken to the add user page

  @admin
  Scenario: admin adds user
    Given "Eli Tracy" is logged in as an "admin"
    Given the user is on the add user page
    When they fill in "Name" with "John Doe"
    And they fill in "Role" with "Coach"
    And they fill in "Email" with "johndoe@example.com"
    And press "Create User"
    Then "John Doe" should be a "Coach" should have the email "johndoe@example.com"
    And I should see "User was successfully created."
  
  @admin
  Scenario: admin can view users
    Given "Tuong Tran" is logged in as an "admin"
    Given user is on the "admin" dashboard
    Then they should see "Name", "Role", and "Email"
    And they should see "Boaty McBoatFace", "Coach", and "BoatyMBF@gmail.com"
  
  @admin
  Scenario: admin can edit users and cancel edit
    Given "Tuong Tran" is logged in as an "admin"
    Given user is on the "admin" dashboard
    When I go to the edit page for "Boaty McBoatFace"
    And I fill in "Email" with "Boaty.McBoatFace@gmail.com"
    And I press "Cancel"
    Then  I should be on the Admin page
    And they should see "Boaty McBoatFace", "Coach", and "BoatyMBF@gmail.com"

  @admin
  Scenario: admin can edit users and save edits
    Given "Tuong Tran" is logged in as an "admin"
    Given user is on the "admin" dashboard
    When I go to the edit page for "Boaty McBoatFace"
    And I fill in "Email" with "Boaty.McBoatFace@gmail.com"
    And press "Update User"
    Then  I should be on the Admin page
    And they should see "Boaty McBoatFace", "Coach", and "Boaty.McBoatFace@gmail.com"

  @admin
  Scenario: admin can delete users
    Given "Tuong Tran" is logged in as an "admin"
    Given user is on the "admin" dashboard
    When I go to the edit page for "Boaty McBoatFace"
    And press "Delete User"
    Then I should be on the Admin page
    And I should not see "Boaty McBoatFace"

  @admin @eli
  Scenario: admin edits users role
    Given "Tuong Tran" is logged in as an "admin"
    Given the user is on the add user page
    Then I should see a 'select' field called 'Role'
    And I should be able to select 'admin' from the 'Role' select
    And I should be able to select 'coach' from the 'Role' select

  @admin @eli
  Scenario: admin edits users role
    Given "Tuong Tran" is logged in as an "admin"
    Given user is on the 'admin' dashboard
    When I go to the edit page for 'Boaty McBoatFace'
    Then I should see a 'select' field called 'Role'
    And I should be able to select 'admin' from the 'Role' select
    And I should be able to select 'coach' from the 'Role' select
