*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://mail.google.com/
${BROWSER}    Chrome
${EMAIL}      your-email@gmail.com
${PASSWORD}   your-password  # Avoid hardcoding, use vaults/env variables in real scenarios

*** Test Cases ***
Gmail Login Test
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      xpath=//input[@type='email']    ${EMAIL}
    Click Button    xpath=//span[text()='Next']
    Sleep           2s  # Wait for password field to load
    Input Text      xpath=//input[@type='password']    ${PASSWORD}
    Click Button    xpath=//span[text()='Next']
    Sleep           5s  # Wait for login to complete
    Page Should Contain    Inbox
    Capture Page Screenshot
    Close Browser
