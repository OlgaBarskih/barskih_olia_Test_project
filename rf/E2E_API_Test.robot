*** Settings ***
Library    JSONLibrary
Library     os
Library     RequestsLibrary
Library     Collections
Resource    resources/E2E_API_resources.robot

*** Test Cases ***
E2E API TEST
# STEP 1 Creates a new auth token
    ${Body}      create dictionary    username=${username}    password=${password}
    ${HEADER}       create dictionary       Content-Type=application/json
    Create New Session  ${BASE_URL}
    ${RESPONSE}     POST On Session         session   ${ENDPOINT}    json=${Body}   headers=${HEADER}
    ${TOKEN}        get value from json     ${RESPONSE.json()}     $.token
    ${TOKEN_0}      get from list    ${TOKEN}   0
    log to console    ${TOKEN_0}
    status code should be    ${RESPONSE.status_code}    200

# STEP 2   Create a new booking with json from file
    ${REQUEST_BODY_1}   ${HEADER_1}    Load Body and Headers From JSON    resources/JSON/Create_Booking_Body.json       resources/JSON/Create_Booking_Headers.json
    ${RESPONSE}     POST On Session         session  ${CREATE_BOOKING_ENDPOINT}    json=${REQUEST_BODY_1}   headers=${HEADER_1}
    ${BOOKING_ID}        get value from json     ${response.json()}     $.bookingid
    ${BOOKING_ID_0}      get from list    ${BOOKING_ID}      0
    ${PARAM_ID}     convert to string    ${BOOKING_ID_0}
    log to console    ${PARAM_ID}
    Response body should be     ${response.content}     Jim
    status code should be    ${RESPONSE.status_code}    200

#  STEP 3   Verify the booking is created
    Create New Session    ${BOOKING_URL}
    ${RESPONSE}     get on session    session            ${PARAM_ID}
    Response body should be     ${response.content}     Jim
    status code should be    ${RESPONSE.status_code}    200

#  STEP 4  Delete booking
    ${HEADER}       create dictionary       Cookie=token=${TOKEN_0}
    ${RESPONSE}     delete on session    session            ${PARAM_ID}    headers=${HEADER}
    Response body should be     ${response.content}     Created
    status code should be    ${RESPONSE.status_code}    201

#  STEP 5 Verify the booking is deleted
    Create New Session    ${BOOKING_URL}
    ${RESPONSE}     get on session    session            ${PARAM_ID}       expected_status=any
    Response body should be     ${response.content}     Not Found
    Status code should be    ${RESPONSE.status_code}    404