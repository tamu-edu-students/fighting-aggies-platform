Feature: View Analytics
Scenario: User navigates to view all players
    Given I am logged in as a coach
    And player "John Smith" exists
    When I click "See Players"
    Then I am on the Players Index page
    And I should see "John Smith"
Scenario: User navigates to view all players but there are no players
    Given the database has been reset
    Given I am logged in as a coach
    When I click "See Players"
    Then I am on the Players Index page
    And I should see "No data"
Scenario: User navigates to view routes 
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See All"
    Then I am on the Route Instances Index page
    And I should see "John Smith"
    And I should see "curl"
Scenario: User navigates to view routes by player
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    Then I am on the By Player page
    And I should see "John Smith"
    And I should see "curl"
    And I should see "0.00%"


