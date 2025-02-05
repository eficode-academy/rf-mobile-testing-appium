*** Settings ***
Library    AppiumLibrary


*** Variables ***
${APPIUM_PORT}    4555
${APPIUM_URL}    http://localhost:${APPIUM_PORT}
${AUTOMATION_NAME}    uiautomator2
${PLATFORM_NAME}    android
${PLATFORM_VERSION}    14.0
${DEVICE_NAME}    Pixel_7_Pro_API_34

${APP_PACKAGE}    com.google.android.deskclock
${APP_ACTIVITY}    com.android.deskclock.DeskClock

${ID}    ${APP_PACKAGE}:id/
${TAB_MENU_ALARM}    ${ID}tab_menu_alarm
${NEW_ALARM_BUTTON}    ${ID}fab


*** Test Cases ***
Open clock app
    Open Application    ${APPIUM_URL}
    ...    automationName=${AUTOMATION_NAME}
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    
    Click Element    ${TAB_MENU_ALARM}
    Wait Until Element Is Visible    ${NEW_ALARM_BUTTON}

    Log Source
    Capture Page Screenshot
