*** Keywords ***
# platform-specific keyword
# usage: ios.Open mobile application
# ${PLATFORM}.Open mobile application
Assemble settings for appium
    &{settings_dict} =    Create Dictionary
    ...    automationName=${DEVICE.automationName}
    ...    platformName=${DEVICE.platformName}
    ...    platformVersion=${DEVICE.platformVersion}
    ...    deviceName=${DEVICE.deviceName}
    ...    udid=${DEVICE.udid}
    ...    app=${IPA_FILE}
    RETURN    &{settings_dict}