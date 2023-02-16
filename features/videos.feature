Feature: videos
 
  @videos 
  Scenario:
    Given I am logged in as a data manager
    Given I am on the videos dashboard 
    When I click 'Edit' on Test Video 0
    Then I should go to the edit video page for 'Test Video 0' 

  @videos
  Scenario:
    Given I am logged in as a data manager
    Given I am editing 'Test Video 0'
    When I change 'Video Name' to 'changed video name'
    When I change 'Description' to 'changed video description'
    And I click the 'Update Practice Video' button
    Then I should not see 'Test Video 0'
    And I should see 'changed video name'
    And I should see 'change video description'

  @videos 
  Scenario:
    Given I am logged in as a data manager
    Given I am editing 'Test Video 0'
    Then I should be able to edit 'Video Name'
    And I should be able to edit 'Description'
    And I should not be able to edit 'Filename'
    And I should not be able to edit 'Video Create Date'
    And I should not be able to edit 'Video Upload Date'

  @videos @javascript
  Scenario:
    Given I am logged in as a data manager
    Given I am on the videos dashboard
    When I click Test Video 0
    And I should see 'Test Video 0'
    And I should see 'Created 01/01/2023'
    And I should see 'Uploaded 01/04/2023'
    And I should see 'This is a description for test video 0'

  @videos @delete_videos @javascript
  Scenario:
    Given I am logged in as a data manager
    Given I am editing 'Test Video 0'
    When I click the 'Delete' button
    And I click the 'Confirm Delete' button
    Then I should be on the videos dashboard
    And I should not see 'Test Video 0'

  @videos @delete_videos @javascript
  Scenario:
    Given I am logged in as a data manager
    Given I am viewing 'Test Video 0'
    When I click the 'Delete' button
    And I click the 'Cancel Delete' button
    Then I should be on the view 'Test Video 0' page
    
    
