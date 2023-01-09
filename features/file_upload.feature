Feature: file upload

  @skip
  Scenario: user tries uploading to server before selecting folder
    Given the user is logged in and on dashboard
    Then the upload button is disabled

  @skip
  Scenario: user selects incompatible file type
    Given the user is logged in and on dashboard
    When user selects incorrect file type
    Then the upload button is disabled
    Then user should get negative feedback --incompatible upload type

@file_upload_corrupted @skip
  Scenario: user uploads corrupted file
    Given the user is logged in and on dashboard
    When user selects corrupted file
    When user clicks the upload button
    Then user should get negative feedback --incompatible upload file

@file_upload_correct @skip
  Scenario: user uploads file successfully
    Given the user is logged in and on dashboard
    Given the user has uploaded a good file
    When user clicks the upload button
    Then user should get positive feedback --file uploaded successfully
