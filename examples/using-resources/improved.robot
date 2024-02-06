*** Settings ***
Library    AppiumLibrary
Resource    Resources/Clock.resource


*** Variables ***
${APPIUM_PORT}    4723
${APPIUM_URL}    http://localhost:${APPIUM_PORT}
${AUTOMATION_NAME}    uiautomator2
${PLATFORM_NAME}    android
${PLATFORM_VERSION}    14.0
${DEVICE_NAME}    Pixel_3_API_30


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

    Log    ${DEVICE_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}

    Click Element    ${TAB_MENU_ALARM}
    Wait Until Element Is Visible    ${NEW_ALARM_BUTTON}

    Log Source
    Capture Page Screenshot
