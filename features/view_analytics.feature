Feature: View Analytics
Scenario: User navigates to view all routes
    Given I am logged in as a coach
    And player John Smith exists
    When I click "See All"
    Then I am on the Route Instances Index page
    And I should see "John Smith"
Scenario: User navigates to view all routes but there are no routes
    Given the database has been reset
    Given I am logged in as a coach
    When I click "See All"
    Then I am on the Route Instances Index page
    And I should see "No data"
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
Scenario: User navigates to view a specific player
    Given I am logged in as a coach
    And player John Smith exists
    And "John Smith" has run a route
    When I click "See Players"
    Then I am on the Players Index page
    When I click "John Smith"
    Then I am on the Show Player page
    And I should see "John Smith"
Scenario: User navigates to view a specific player who hasn't run any routes
    Given I am logged in as a coach
    And the database has been reset
    And player John Smith exists
    When I click "See Players"
    Then I am on the Players Index page
    When I click "John Smith"
    Then I am on the Show Player page
    And I should see "John Smith"
    And I should see "No routes run"
