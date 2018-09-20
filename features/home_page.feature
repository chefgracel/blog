Feature: Open the blog home page and verify text on the page

Scenario: Open home page and verify text
  Given I navigate to "http://localhost:3000"
  And pause
  Then I should see "From Grace"
