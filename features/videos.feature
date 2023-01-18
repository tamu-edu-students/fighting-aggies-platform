Feature: videos

  Scenario:
    Given I am a data manager
    When I go to the videos dashboard
    Then I should see a list of previously uploaded videos

  Scenario:
    Given I am a data manager
    When I go to the videos dashboard
    And click 'add video'
    Then I should be taken to the add video page

  Scenario:
    Given I am on the add video page
    When I click 'upload video file'
    Then I should see a prompt to choose a video file from my computer

  Scenario:
    Given I am selecting a video file from my computer
    When I choose a valid file type
    And click select
    Then I should get positive feedback 
    And I should see a form to edit the video's metadata

  Scenario:
    Given I am selecting a video file from my computer
    When I choose an invalid file type
    And click select
    Then I should get negative feedback 
    And I should not see a form to edit the video's metadata

  Scenario: 
    Given I have selected a valid filetype from my computer
    When I add 'Practice A' as the 'practice video name'
    And I add 'This is a test practice' as the 'description'
    And hit submit
    Then I should see 'Practice A' as the 'practice video name'
    And I should see 'This is a test practice' as the 'description'
    And I should see a valid time stamp as the 'practice date'
    And I should see a valid time stamp as the 'upload date'
    And I should see 'testVideo' as the 'filename'
