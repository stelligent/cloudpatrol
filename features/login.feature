Feature: CloudPatrol Login
  As an end user
  I would like to login to CloudPatrol
  So that I can access CloudPatrol to do my Devops-y work

Scenario: Login as default administrator
  Given the CloudPatrol URL has been specified
    And the password has been specified
   When I navigate to /login
    And I login with username "admin"
   Then I should see the text "Settings"
    And I should see the text "export as JSON config file"
