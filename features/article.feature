Feature: Manage Comments

    As an admin user
    I want to be able to create and delete comments

    # To run before every scenario
    Background: Create user, login and create article
        Given I create user as name "bipinkarki" with password "asdfasdf"
        Then I create article by title "My Article" with content "My content"
        Then I login as "bipinkarki" and password "asdfasdf"

    Scenario: login with correct password 

        Given I am on all articles path
        Then I should see "Signout"

        And I press "Signout"
        Then I should see "Signed out successfully."

        And I press "Login"
        Then I should see "Please sign in"

        And I login with name "bipinkarki" and password "asdfasdf"
        And I press "Log in"
        Then I should see "Signed in successfully."

    Scenario: login with empty username and password 

        Given I am on all articles path
        Then I should see "Signout"

        And I press "Signout"
        Then I should see "Signed out successfully."

        And I press "Login"
        Then I should see "Please sign in"

        And I login with name "" and password ""
        And I press "Log in"
        Then I should see "Invalid Username or password."

    Scenario: login with only password

        Given I am on all articles path
        Then I should see "Signout"

        And I press "Signout"
        Then I should see "Signed out successfully."

        And I press "Login"
        Then I should see "Please sign in"

        And I login with name "" and password "bipinkarki"
        And I press "Log in"
        Then I should see "Invalid Username or password."

    Scenario: login with only username

        Given I am on all articles path
        Then I should see "Signout"

        And I press "Signout"
        Then I should see "Signed out successfully."

        And I press "Login"
        Then I should see "Please sign in"

        And I login with name "bipinkarki" and password ""
        And I press "Log in"
        Then I should see "Invalid Username or password."

    Scenario: login with incorrect password 

        Given I am on all articles path
        Then I should see "Signout"

        And I press "Signout"
        Then I should see "Signed out successfully."

        And I press "Login"
        Then I should see "Please sign in"

        And I login with name "invalid_user" and password "invalid_password"
        And I press "Log in"
        Then I should see "Invalid Username or password."

    Scenario: Create Comment

        Given I am on all articles path
        Then I should see "My Article"

        And I press "My Article"
        Then I should see "written by : bipinkarki"

        And I press "Create comment"
        Then I should see "New Comment"

        And I create a comment with name "Bipin" and body "This is my comment"
        And I press "Create Comment"
        Then I should see "Comment was successfully created."
    
    Scenario: Delete Comment

        Given I am on all articles path
        Then I should see "My Article"

        And I press "My Article"
        Then I should see "written by : bipinkarki"

        And I press "Create comment"
        Then I should see "New Comment"

        And I create a comment with name "Bipin" and body "This is my comment"
        And I press "Create Comment"
        Then I should see "Comment was successfully created."

        And I press "delete"
        Then I should see "Comment was successfully destroyed."