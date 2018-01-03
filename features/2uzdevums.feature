Feature: 2.uzdevums - izveidot environment,globālie mainīgie, kolekcijas,rekvesti.

  Scenario: 2.uzdevums
    When I login in apimation as regular user
    Then I create a new environment called PREPROD in project Rest API
    Then I add global variable - username and password and project id
    Then I create 2 collections - Login and Projects
    Then I create 2 requests: login and set project active

    Scenario: 3.uzdevums
      When I login in apimation as regular user
      Then I create a new environment called PREPROD in project Rest API
      Then I add global variable - username and password and project id
      Then I create 2 collections - Login and Projects
      Then I create 2 requests: login and set project active
      And I create test case with name: Set active project