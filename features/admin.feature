Feature: admin
  
  @admin
  Scenario: admin navigates to add user
    Given I am logged in as an administrator
    When they click the add user button
    Then they should be taken to the add user page

  @admin
  Scenario: admin adds user
    Given I am logged in as an administrator
    Given the user is on the add user page
    When they fill in "Name" with "John Doe"
    And they select 'Coach' from the 'Role' select
    And they fill in "Email" with "johndoe@example.com"
    And press "Create User"
    Then "John Doe" should be a "Coach" should have the email "johndoe@example.com"
    And I should see "User was successfully created."
  
  @admin
  Scenario: admin can view users
    Given the database has been reset
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    Then they should see "Name"
    And they should see "Role"
    And they should see "Email"
    And they should see "Boaty McBoatFace"
    And they should see "Coach" 
    And they should see "BoatyMBF@gmail.com"
  
  @admin
  Scenario: admin can edit users and cancel edit
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for "Boaty McBoatFace"
    And I fill in "Email" with "Boaty.McBoatFace@gmail.com"
    And I press "Cancel"
    Then  I should be on the Admin page
    And they should see "Boaty McBoatFace"
    And they should see "Coach" 
    And they should see "BoatyMBF@gmail.com"

  @admin
  Scenario: admin can edit users and save edits
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for "Boaty McBoatFace"
    And I fill in "Email" with "Boaty.McBoatFace@gmail.com"
    And press "Update User"
    Then I should be on the Admin page
    And they should see "Boaty McBoatFace"
    And they should see "Coach" 
    And they should see "Boaty.McBoatFace@gmail.com"

  @admin
  Scenario: admin can delete users
    Given the database has been reset
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for "Boaty McBoatFace"
    And press "Delete User"
    Then I should be on the Admin page
    And I should not see "Boaty McBoatFace"

  @admin @eli
  Scenario: admin edits users role
    Given I am logged in as an administrator
    Given the user is on the add user page
    Then I should see a 'select' field called 'Role'
    And I should be able to select 'Admin' from the 'Role' select
    And I should be able to select 'Coach' from the 'Role' select

  @admin @eli
  Scenario: admin edits users role
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for 'Boaty McBoatFace'
    Then I should see a 'select' field called 'Role'
    And I should be able to select 'Admin' from the 'Role' select
    And I should be able to select 'Coach' from the 'Role' select
