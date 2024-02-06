*** Settings ***
Library    AppiumLibrary
Resource    filename/${PLATFORM}.resource
Resource    filename/device_${PLATFORM}.resource
Resource    filename/locators_${PLATFORM}.resource

*** Variables ***
# defaults
${PLATFORM}    android
${APPIUM_URL}    http://localhost:${DEVICE.appiumPort}

*** Test Cases ***
Open clock app for any device
    # Make a dictionary for logging purposes
    &{appium_settings} =    Run Keyword    ${PLATFORM}.Assemble settings for appium

    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}

    Click Element    ${TAB_MENU_ALARM}
    Wait Until Element Is Visible    ${NEW_ALARM_BUTTON}

    Log Source
    Capture Page Screenshot
