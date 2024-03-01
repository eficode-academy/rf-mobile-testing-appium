*** Settings ***
Library     AppiumLibrary
Resource    iPhoneSim.robot
Resource    Calendar.robot

Test Setup       Install And Open App
Test Teardown    Close Application

*** Variables ***
${EVENT_NAME}    Robot framework mobile testing workshop

*** Test Cases ***
iOS Calendar POC
    # Simple POC to open calendar app, do 1 entry and then delete it.
    Wait and Click                        ${ADD_BUTTON}
    Wait Until Element Is Visible         ${TITLE_FIELD}
    Element Should Be Disabled            ${ADD_BUTTON}
    Input Text                            ${TITLE_FIELD}    ${EVENT_NAME}
    Click Element                         ${ALLDAY_CHECKBOX}
    Element Should Be Enabled             ${ADD_BUTTON}
    Click Element                         ${ADD_BUTTON}
    Wait and Click                        //XCUIElementTypeButton[contains(@name, 'Today')]
    Wait and Click                        //XCUIElementTypeButton[@name="${EVENT_NAME}, All day"]
    Wait and Click                        ${DELETE_EVENT}
    Wait Until Element Is Visible         ${DELETE_CONFIRM}
    Click Element                         ${DELETE_EVENT_BUTTON}
    Wait and Click                        //XCUIElementTypeButton[@name="February"]
    Log To Console                        Done with POC


*** Keywords ***
Install And Open App
    # Make a dictionary for logging purposes
    &{appium_settings} =    Create Dictionary
    ...    automationName=${AUTOMATION_NAME}
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    udid=${UDID}
    ...    app=${APP}
    ...    wdaLocalPort=${WDALOCALPORT}
    ...    locale=${LOCALE}
    ...    language=${LANGUAGE}
    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}


Wait and Click
    [Arguments]     ${locator}
    Wait Until Element Is Visible         ${locator}
    Click Element                         ${locator}
