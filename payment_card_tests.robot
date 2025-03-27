*** Settings ***
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${BROWSER}        chrome
${URL}            http://example.com
${VALID_CARD}     4111111111111111
${INVALID_CARD}   1234567890123456
${EXPIRY_DATE}    12/25
${CVV}            123

*** Test Cases ***
Test Valid Credit Card Payment
    [Documentation]    Test the payment process with a valid credit card
    Open Browser    ${URL}    ${BROWSER}
    Input Card Details    ${VALID_CARD}    ${EXPIRY_DATE}    ${CVV}
    Submit Payment
    Verify Payment Success
    Close Browser

Test Invalid Credit Card Payment
    [Documentation]    Test the payment process with an invalid credit card
    Open Browser    ${URL}    ${BROWSER}
    Input Card Details    ${INVALID_CARD}    ${EXPIRY_DATE}    ${CVV}
    Submit Payment
    Verify Payment Failure
    Close Browser

Test Expired Credit Card Payment
    [Documentation]    Test the payment process with an expired credit card
    Open Browser    ${URL}    ${BROWSER}
    Input Card Details    ${VALID_CARD}    12/20    ${CVV}
    Submit Payment
    Verify Payment Failure
    Close Browser

*** Keywords ***
Input Card Details
    [Arguments]    ${card_number}    ${expiry_date}    ${cvv}
    Input Text    id=card_number    ${card_number}
    Input Text    id=expiry_date    ${expiry_date}
    Input Text    id=cvv    ${cvv}

Submit Payment
    Click Button    id=submit_payment

Verify Payment Success
    Page Should Contain    Payment Successful

Verify Payment Failure
    Page Should Contain    Payment Failed
