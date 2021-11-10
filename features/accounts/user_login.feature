Feature: User Login


    As a user
    Such that I want to use the globalreader system
    I want to login to the system

    Scenario: Login from GlobalReader home page (Success)
        Given the following user are on the system
            | username | password | name      | email             |
            | kalabu99 | abcde    | Kala Bula |kalabu99@gmail.com |
            | malabu99 | 12345    | Mala Bula |malabu99@gmail.com |
        And I open GlobalReader home page
        And I clicked on Login Button
        And I enterred my username "kalabu99" and password "abcde"
        When I submit the information
        Then I should receive a sucessful login confirmation message

    Scenario: Scenario: Login from GlobalReader home page (Fail)
        Given the following user are on the system
            | username | password | name      | email             |
            | kalabu99 | abcde    | Kala Bula |kalabu99@gmail.com |
            | malabu99 | 12345    | Mala Bula |malabu99@gmail.com |
        And I open GlobalReader home page
        And I clicked on Login Button
        And I enterred my username "kalabu99" and password "asdfg"
        When I submit the information
        Then I should receive a failed login message