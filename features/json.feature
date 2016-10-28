@vcr
Feature: Get JSON

  Background:
    Given I send and accept JSON

  Scenario: Get the root JSON
    When I send a GET request to "/"
    Then the response status should be "200"
    And the JSON response should have "$.[0]['name']" with the text "gigs"

  Scenario: Get JSON for gigs
    When I send a GET request to "/gigs"
    Then the response status should be "200"
    And the JSON response should have "$.[10]['venue']" with the text "Hoxton Underbelly"
    And the JSON response should have "$.[1]['price']['amount']" with the text "4.0"
    And the JSON response should have "$.[1]['price']['currency']" with the text "GBP"

  Scenario: Get JSON for pictures
    When I send a GET request to "/pictures"
    Then the response status should be "200"
    And the JSON response should have "$.[0]['title']" with the text "Cafe 1001, March 2016"
    And the JSON response should have "$.[2]['license']['type']" with the text "Attribution-NonCommercial-ShareAlike"

  Scenario: Get JSON for videos
    When I send a GET request to "/videos"
    Then the response status should be "200"
    And the JSON response should have "$.[3]['url']" with the text "https://vimeo.com/110133117"

  Scenario: Get JSON for sounds
    When I send a GET request to "/sounds"
    Then the response status should be "200"
    And the JSON response should have "$.[4]['url']" with the text "http://soundcloud.com/rawfunkmaharishi/letter-for-leona"

  Scenario: Get JSON for photographers
    When I send a GET request to "/photographers"
    Then the response status should be "200"
    And the JSON response should have "$.[0]['name']" with the text "kim"

  Scenario: Get JSON for a photographer
    When I send a GET request to "/photographers/kim"
    Then the response status should be "200"
    And the JSON response should have "$['website']" with the text "http://www.kimberlycabbott.com/"
