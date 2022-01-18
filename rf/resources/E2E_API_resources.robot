*** Settings ***
Library    JSONLibrary
Library     os
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com
${BOOKING_URL}  https://restful-booker.herokuapp.com/booking/
${ENDPOINT}     /auth
${CREATE_BOOKING_ENDPOINT}  /booking
${username}     username
${password}     password

*** Keywords ***
Create New Session
    [Arguments]    ${URL}
    create Session    session    ${URL}

Load Body and Headers From JSON
    [Arguments]    ${JSON_Body}     ${JSON_Headers}
    ${REQUEST_BODY}     load json from file     ${JSON_Body}
    ${HEADER}       load json from file    ${JSON_Headers}
    [Return]     ${REQUEST_BODY}         ${HEADER}

Status code should be
    [Arguments]     ${RESPONSE.status_code}     ${EXP_SC}
    ${STATUS_CODE}      convert to string    ${RESPONSE.status_code}
    log to console    ${STATUS_CODE}
    should be equal    ${STATUS_CODE}       ${EXP_SC}
    [Return]    ${STATUS_CODE}

Response body should be
    [Arguments]     ${response.content}    ${EXP_body}
    ${BODY}     convert to string    ${response.content}
    log to console    ${BODY}
    should contain      ${BODY}    ${EXP_body}
    [Return]    ${BODY}