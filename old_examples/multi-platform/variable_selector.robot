*** Settings ***
Library    AppiumLibrary
Resource    variable/common.resource
Resource    variable/device.resource
Resource    variable/locators.resource


*** Variables ***
# defaults
${PLATFORM}    android
${APPIUM_URL}    http://localhost:${DEVICE.appiumPort}

*** Test Cases ***
Open clock app for any device
    # Make a dictionary for logging purposes
    &{appium_settings} =    Run keyword    Assemble ${PLATFORM} settings for appium


    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}

    Click Element    ${${PLATFORM}_TAB_MENU_ALARM}
    Wait Until Element Is Visible    ${${PLATFORM}_NEW_ALARM_BUTTON}

    Log Source
    Capture Page Screenshot
