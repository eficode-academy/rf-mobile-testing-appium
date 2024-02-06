*** Keywords ***
# platform-specific keyword
# usage: android.Open mobile application
# ${PLATFORM}.Open mobile application
Assemble settings for appium
    &{settings_dict} =    Create Dictionary
    ...    automationName=${DEVICE.automationName}
    ...    platformName=${DEVICE.platformName}
    ...    platformVersion=${DEVICE.platformVersion}
    ...    deviceName=${DEVICE.deviceName}
    ...    udid=${DEVICE.udid}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    RETURN    &{settings_dict}