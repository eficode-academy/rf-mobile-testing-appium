*** Settings ***
Library    AppiumLibrary
Resource    ../resourced/Resources/Clock.resource

Variables    importer.py    Pixel_6_API_34

*** Variables ***
${DEVICE}    ${DEVICES[0]}
${APPIUM_URL}    http://localhost:${DEVICE.port}


*** Test Cases ***
Importer debug
    Get Variables
    Log To Console    ${DEVICE}


Open clock app for any device
    # Make a dictionary for logging purposes
    &{appium_settings} =    Create Dictionary
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    platformName=${DEVICE.platformName}
    ...    automationName=${DEVICE.automationName}
    ...    platformVersion=${DEVICE.platformVersion}
    ...    deviceName=${DEVICE.deviceName}
    ...    udid=${DEVICE.udid}

    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}

    Click Element    ${TAB_MENU_ALARM}
    Wait Until Element Is Visible    ${NEW_ALARM_BUTTON}

    Log Source
    Capture Page Screenshot
