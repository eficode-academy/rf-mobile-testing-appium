*** Settings ***
Library    AppiumLibrary
Resource    ../resourced/Resources/Clock.resource

Variables    importer.py    Pixel_6_API_34    Pixel_6_API_34_2

*** Variables ***
&{One}    &{DEVICES[0]}    alias=one
&{Two}    &{DEVICES[1]}    alias=two


*** Test Cases ***
Importer debug
    Get Variables
    Log To Console    ${DEVICES}
    Log    ${One}
    Log    ${Two}


Open clock app for any device
    Open Clock App    ${One}
    Open Alarms View
    Capture Page Screenshot

    Open Clock App    ${Two}
    Capture Page Screenshot

    Switch Application    ${One.alias}
    Click Element    ${NEW_ALARM_BUTTON}
    Sleep    1s
    Capture Page Screenshot

*** Keywords ***
Open Clock App
    [Arguments]    ${DEVICE}
    &{appium_settings} =    Create Dictionary
    ...    alias=${DEVICE.alias}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    platformName=${DEVICE.platformName}
    ...    automationName=${DEVICE.automationName}
    ...    platformVersion=${DEVICE.platformVersion}
    ...    deviceName=${DEVICE.deviceName}
    ...    udid=${DEVICE.udid}
    VAR    ${APPIUM_URL}    http://localhost:${DEVICE.port}
    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}


Open Alarms View
    Click Element    ${TAB_MENU_ALARM}
    Wait Until Element Is Visible    ${NEW_ALARM_BUTTON}