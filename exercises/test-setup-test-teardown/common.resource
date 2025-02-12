*** Settings ***
Library     AppiumLibrary

*** Variables ***
${APPIUM_PORT}         4723
${APPIUM_URL}          http://localhost:${APPIUM_PORT}
${AUTOMATION_NAME}     uiautomator2
${PLATFORM_NAME}       android
${PLATFORM_VERSION}    14.0
${DEVICE_NAME}         Pixel_7_Pro_API_34
${UDID}                ${EMPTY}

${APP_PACKAGE}         bored.codebyk.mintcalc
${APP_ACTIVITY}        MainActivity


*** Keywords ***
Start Mint Calendar
    Open Application    ${APPIUM_URL}
    ...    automationName=${AUTOMATION_NAME}
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    deviceName=${DEVICE_NAME}
    ...    udid=${UDID}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}

Clear screen
    Click element    accessibility_id=C
