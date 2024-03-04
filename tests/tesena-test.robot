*** Settings ***

Documentation     Example test suite for Tesena interview

Resource          ../resources/keywords.resource

Suite Setup    Test Suite Setup
Test Teardown    Close Context    ALL
Test Setup    Open Target Webpage
Suite Teardown    Close Browser    ALL

*** Test Cases ***

Register new user account
    Open Login/Signup Page
    Enter Signup Values And Click Signup
    Enter Signup Screen Detailed Values And Create Account
    Get Text    //*[@data-qa="account-created"]    ==    ACCOUNT CREATED!
    Click    //*[@data-qa="continue-button"]
    Assert User ${user_id} Is Logged In

Login with correct user credentials
    Open Login/Signup Page
    Enter Valid User Credentials And Login
    Assert User ${user_id} Is Logged In

Login with incorrect user credentials
    Open Login/Signup Page
    Enter Invalid User Credentials And Login
    Get Element    "Your email or password is incorrect!"

Delete existing user account
    [Setup]    Run Keywords    Open Target Webpage    
    ...                        Open Login/Signup Page
    ...                        Enter Valid User Credentials And Login
    Click     "Delete Account"
    Get Text    //*[@data-qa="account-deleted"]    ==    ACCOUNT DELETED!
    Click    //*[@data-qa="continue-button"]
    Get Element    id=slider
