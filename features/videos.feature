Feature: videos

  # @videos
  # Scenario:
  #   Given I am a data manager
  #   Given videos have been previously uploaded
  #   When I go to the videos dashboard
  #   Then I should see a list of previously uploaded videos
  #
  # @videos
  # Scenario:
  #   Given I am a data manager
  #   When I go to the videos dashboard
  #   And I click 'Add Video'
  #   Then I should be taken to the add video page
  #
  # @videos
  # Scenario:
  #   Given I am on the add video page
  #   When I click 'upload video file'
  #   Then I should see a prompt to choose a video file from my computer
  #
  # @videos
  # Scenario:
  #   Given I am selecting a video file from my computer
  #   When I choose a valid file type
  #   And click select
  #   Then I should get positive feedback 
  #   And I should see a form to edit the video's metadata
  #
  # @videos
  # Scenario:
  #   Given I am selecting a video file from my computer
  #   When I choose an invalid file type
  #   And click select
  #   Then I should get negative feedback 
  #   And I should not see a form to edit the video's metadata
  #
  # @videos
  # Scenario: 
  #   Given I have selected a valid filetype from my computer
  #   When I add 'Practice A' as the 'practice video name'
  #   And I add 'This is a test practice' as the 'description'
  #   And hit submit
  #   Then I should see 'Practice A' as the 'practice video name'
  #   And I should see 'This is a test practice' as the 'description'
  #   And I should see a valid time stamp as the 'practice date'
  #   And I should see a valid time stamp as the 'upload date'
  #   And I should see 'testVideo' as the 'filename'
  
  @videos
  Scenario:
    Given I am on the videos dashboard 
    When I click 'Edit' on Test Video 0
    Then I should go to the edit video page for 'Test Video 0' 

  @videos
  Scenario:
    Given I am editing 'Test Video 0'
    When I change 'Video Name' to 'changed video name'
    When I change 'Description' to 'changed video description'
    And I click the 'Update Practice Video' button
    Then I should not see 'Test Video 0'
    And I should see 'changed video name'
    And I should see 'change video description'

  @videos
  Scenario:
    Given I am editing 'Test Video 0'
    Then I should be able to edit 'Video Name'
    And I should be able to edit 'Description'
    And I should not be able to edit 'Filename'
    And I should not be able to edit 'Video Create Date'
    And I should not be able to edit 'Video Upload Date'
