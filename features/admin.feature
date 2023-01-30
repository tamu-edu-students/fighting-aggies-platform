Feature: admin
  
  Scenario: admin navigates to add user
    Given I am logged in as an administrator
    When they click the add user button
    Then they should be taken to the add user page

  Scenario: admin adds user
    Given I am logged in as an administrator
    Given the user is on the add user page
    When they fill in "Name" with "John Doe"
    And they select 'Coach' from the 'Role' select
    And they fill in "Email" with "johndoe@example.com"
    And press "Create User"
    Then "John Doe" should be a "Coach" should have the email "johndoe@example.com"
    And I should see "User was successfully created."
  
  Scenario: admin can view users
    Given the database has been reset
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    Then they should see "Name"
    And they should see "Role"
    And they should see "Boaty McBoatFace"
    And they should see "Coach" 

  Scenario: admin can edit users and cancel edit
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for "Boaty McBoatFace"
    Then I should be on the user 'edit' page for "Boaty McBoatFace"
    And I fill in "Name" with "Boaty McNewLastName"
    And I press "Cancel"
    Then I should be on the Admin page
    And they should see "Boaty McBoatFace"
    And they should see "Coach"

  Scenario: admin can edit users and save edits
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for "Boaty McBoatFace"
    And I fill in "Name" with "Boaty McNewLastName"
    And press "Update User"
    Then I should be on the Admin page
    And they should see "Boaty McNewLastName"
    And they should see "Coach" 

  @javascript
  Scenario: admin can delete users
    Given the database has been reset
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for "Boaty McBoatFace"
    And press "Delete User"
    Then I should see 'Confirm Delete' 

  @javascript
  Scenario: admin deletes user
    # Given "Tuong Tran" is logged in as an "admin"
    Given I am logged in as an administrator
    Given user 'Boaty McBoatFace' exists
    Given I am on the user 'edit' page for 'Boaty McBoatFace'
    When press "Delete User"
    And press 'Confirm Delete'
    Then I should be on the Admin page
    And I should not see "Boaty McBoatFace"

  @javascript
  Scenario: admin cancels user delete
    # Given "Tuong Tran" is logged in as an "admin"
    Given I am logged in as an administrator
    Given user 'Boaty McBoatFace' exists
    Given I am on the user 'edit' page for 'Boaty McBoatFace'
    When press "Delete User"
    And press 'cancel-button'
    Then I should be on the user 'edit' page for 'Boaty McBoatFace'
    And I should see "Boaty McBoatFace"

  Scenario: admin edits users role
    Given I am logged in as an administrator
    Given the user is on the add user page
    Then I should see a 'select' field called 'Role'
    And I should be able to select 'Admin' from the 'Role' select
    And I should be able to select 'Coach' from the 'Role' select
    And I should be able to select 'Data Manager' from the 'Role' select

  Scenario: admin edits users role
    Given user 'Boaty McBoatFace' exists
    And I am logged in as an administrator
    When I go to the edit page for 'Boaty McBoatFace'
    Then I should see a 'select' field called 'Role'
    And I should be able to select 'Admin' from the 'Role' select
    And I should be able to select 'Coach' from the 'Role' select
    And I should be able to select 'Data Manager' from the 'Role' select
