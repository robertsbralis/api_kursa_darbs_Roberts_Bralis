Feature: 2.uzdevums/3.uzdevums - izveidot environment,globālie mainīgie, kolekcijas,rekvesti.

  Scenario: 2.uzdevums
    When I login in apimation as regular user
    Then I create a new environment called PREPROD in project Rest API
    Then I add global variable - username
    Then I add global variable - password
    Then I add global variable - project_id
    Then I create collection - Login
    Then I create collection - Projects
    Then I create request: login
    Then I create request: set project active


    Scenario: 3.uzdevums
      When I login in apimation as regular user
      Then I create a new environment called PREPROD in project Rest API
      Then I add global variable - username
      Then I add global variable - password
      Then I add global variable - project_id
      Then I create collection - Login
      Then I create collection - Projects
      Then I create request: login
      Then I create request: set project active
      And I create test case with name: Set active project