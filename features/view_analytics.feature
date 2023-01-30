Feature: View Analytics
Scenario: User navigates to view all players
    Given I am logged in as a coach
    And player John Smith exists
    When I click "See Players"
    Then I am on the Players Index page
    And I should see "John Smith"
Scenario: User navigates to view all players but there are no players
    Given the database has been reset
    Given I am logged in as a coach
    When I click "See Players"
    Then I am on the Players Index page
    And I should see "No data"
