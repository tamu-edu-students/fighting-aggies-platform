Feature: passwordless

Scenario: Redirect to sign_in page
    Given I am on the home page
    And I follow "Single Sign-On Email"
    Then I should be on the sign_in page

Scenario: Input on sign_in submission
    Given I am on the sign_in page
    And I fill in "Something@gmail.com"
    And I press button "Send magic link"
    Then the page should have "If we found you in the system, we've sent you an email."

Scenario: No input on sign_in submission
    Given I am on the sign_in page
    And I press button "Send magic link"
    Then I should see "Please fill out this field."

Scenario: User email input on sign_in submission
    Given I am on the sign_in page
    And I exist as a user
    And I fill in "pleasework@gmail.com"
    And I press button "Send magic link"
    Then the page should have "If we found you in the system, we've sent you an email."
