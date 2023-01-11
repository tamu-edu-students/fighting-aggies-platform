Feature: file upload

  @skip
  Scenario: user tries uploading to server before selecting folder
    Given I am logged in as a coach
    Then the upload button is disabled

  @skip
  Scenario: user selects incompatible file type
    Given I am logged in as a coach
    When user selects incorrect file type
    Then the upload button is disabled
    Then user should get negative feedback --incompatible upload type

@file_upload_corrupted @skip
  Scenario: user uploads corrupted file
    Given I am logged in as a coach
    When user selects corrupted file
    When user clicks the upload button
    Then user should get negative feedback --incompatible upload file

@file_upload_correct @skip
  Scenario: user uploads file successfully
    Given I am logged in as a coach
    Given the user has uploaded a good file
    When user clicks the upload button
    Then user should get positive feedback --file uploaded successfully
