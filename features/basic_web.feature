@web
Feature: Basic Web Tests

  Generic tests to make sure Cucumber and Selenium are working.

  Background: Some basic web tests to orient a QA to Cucumber-Selenium web testing

  Scenario: Get to cucumber.io
    Given the user can connect to "http://www.cucumber.io/" with title "Cucumber"

  Scenario Outline: Search for Cucumber
    Given the user can connect to "http://www.google.com" with title "Google"
    When the user queries for "cucumber"
    Then the "<link>" "<homepage>" is present
    When the user clicks the cucumber link
    Then that "<homepage>" is displayed

    Examples:
      | homepage | link |
      | https://cucumber.io/ | Cucumber |
