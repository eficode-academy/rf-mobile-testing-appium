*** Settings ***
Library    AppiumLibrary
Resource    ${phone}.resource

*** Variables ***
# download APK from https://f-droid.org/en/packages/org.fossify.calendar/
${APP_PACKAGE}     org.fossify.calendar
${APP_ACTIVITY}    org.fossify.calendar.activities.MainActivity

${PLUS_BUTTON}    ${APP_PACKAGE}:id/calendar_fab
${APK_LOC}    ${APK_DIRECTORY}/org.fossify.calendar_3.apk

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
    ...    app=${APK_LOC}
    ...    udid=${UDID}

    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}

    Wait Until Element Is Visible    ${PLUS_BUTTON}
    Sleep    20
    Log Source
    Capture Page Screenshot
    [Teardown]    Close All Applications