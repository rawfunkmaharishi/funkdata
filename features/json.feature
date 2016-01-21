@vcr
Feature: Get JSON

  Background:
    Given I send and accept JSON

  Scenario: Get JSON for a repo
    When I send a GET request to "/gigs"
    Then the response status should be "200"
    And the JSON response should have "$.[10]['venue']" with the text "Hoxton Underbelly"
