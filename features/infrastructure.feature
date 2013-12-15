Feature: Scripted Provisioning of CloudPatrol Environment
    As a Developer
    I would like my CloudPatrol Environment provisioned correctly
    so I can deploy applications to it

    Background:
        Given I am sshed into the environment

    Scenario: Is the proper version of Ruby installed?
        When I run "ruby -v"
        Then I should see "ruby 1.9.3"

    Scenario Outline: These gems should be present
        When I run "sudo gem list"
        Then I should see "<output>"

        Examples: gems should be present
            | output  |
            | bundler |
            | aws-sdk |