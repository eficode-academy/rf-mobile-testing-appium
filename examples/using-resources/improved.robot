*** Settings ***
Library    AppiumLibrary
Resource    Resources/Clock.resource
Resource    ${phone}.resource

*** Variables ***

*** Test Cases ***
Open clock app for any device
    # Make a dictionary for logging purposes
    &{appium_settings} =    Create Dictionary
    ...    automationName=${AUTOMATION_NAME}
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    udid=${UDID}

    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}

    Click Element    ${TAB_MENU_ALARM}
    Wait Until Element Is Visible    ${NEW_ALARM_BUTTON}

    Log Source
    Capture Page Screenshot
    [Teardown]    Close All Applications