Feature: Basic API Tests

  Re-creating PostMan tests using Cucumber/Ruby

  Background: Trying out automating REST API tests

  Scenario Outline: Some PostMan Stuff
    Given the client can make an API "<http>" call to the "<host>" "<service>" with this "<message>"
    Then the client will receive the proper "<message>" in return

    Examples:
    | http | host | service | message |
    | get | https://echo.getpostman.com | /basic-auth | Basic-Auth-Success |
    | get | https://echo.getpostman.com | /digest-auth | Auth-Request-Fail |
    #| get | https://echo.getpostman.com | /digest-auth | Auth-Request-Success |
    | get | https://echo.getpostman.com | /oauth1 | OAuth-Pass |
