*** Settings ***
Resource    device.resource

*** Variables ***
${APP_PACKAGE}    com.google.android.deskclock
${APP_ACTIVITY}    com.android.deskclock.DeskClock

*** Keywords ***

# common keyword
Open clock app
    # Make a dictionary for logging purposes
    &{appium_settings} =    Run Keyword    Assemble ${PLATFORM} settings for appium
    Log    ${APPIUM_URL} ${appium_settings}
    Open Application    ${APPIUM_URL}    &{appium_settings}


# platform-specific keyword
# usage: Run keyword    Open ${PLATFORM} mobile application

Assemble ios settings for appium
    &{settings_dict} =    Create Dictionary
    ...    &{IOS_DEVICE}
    ...    app=${IPA_FILE}
    RETURN    &{settings_dict}

Assemble android settings for appium
    &{settings_dict} =    Create Dictionary
    ...    &{ANDROID_DEVICE}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    RETURN    &{settings_dict}
