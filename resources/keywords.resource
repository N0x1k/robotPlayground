*** Settings ***

Library           Browser

*** Variables ***
${url}                https://automationexercise.com/
${user_id}            test-user
${user_email}         test-tesena@email.com
${user_password}      test-password

*** Keywords ***

Test Suite Setup
    New Browser    chromium    headless=true
    Set Browser Timeout    10s

Open Target Webpage
    New Context
    New Page    ${url}
    Verify Title Of The Target Webpage

Verify Title Of The Target Webpage
    Get Title    equal    Automation Exercise

Open Login/Signup Page
    Click     "Signup / Login"
    
Fill In Login Email And Password
    [Arguments]    ${email}    ${password}
    Fill Text    //*[@data-qa="login-email"]    ${email}
    Fill Text    //*[@data-qa="login-password"]    ${password}

Enter Valid User Credentials And Login
    Fill In Login Email And Password    ${user_email}    ${user_password}
    Click    //*[@data-qa="login-button"]

Enter Invalid User Credentials And Login
    Fill In Login Email And Password    incorrect@email.com    login
    Click    //*[@data-qa="login-button"]
    
Assert User ${user} Is Logged In
    Get Element    " Logged in as "
    Get Element    "${user}"
    
Enter Signup Values And Click Signup
    Fill Text    //*[@data-qa="signup-name"]    ${user_id}
    Fill Text    //*[@data-qa="signup-email"]    ${user_email}
    Click    //*[@data-qa="signup-button"]
    
Enter Signup Screen Detailed Values And Create Account
    &{inputs}    Create Dictionary    password=${user_password}    first_name=test    last_name=user    address1=test address
    ...                               state=test state    city=test city    zipcode=12345    mobile_number=123456789
    FOR   ${element_id}    IN    @{inputs}
        Fill Text    id=${element_id}    ${inputs}[${element_id}]
    END
    Select Options By    id=country    value    United States
    Click    //*[@data-qa="create-account"]
