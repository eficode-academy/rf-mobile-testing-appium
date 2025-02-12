*** Settings ***
Library      AppiumLibrary
Resource     ${USE_DEVICE}.resource

*** Variables ***
${APPIUM_URL}          http://localhost:${DEVICE.appium_port}
${APP_PACKAGE}         bored.codebyk.mintcalc
${APP_ACTIVITY}        MainActivity

&{SETTINGS}    automationName=${DEVICE.automationName}
...            platformName=${DEVICE.platformName}
...            platformVersion=${DEVICE.platformVersion}
...            deviceName=${DEVICE.deviceName}
...            udid=${DEVICE.udid}
...            appPackage=${APP_PACKAGE}
...            appActivity=${APP_ACTIVITY}

*** Keywords ***
Start Mint Calendar
    Log    ${APPIUM_URL} &{SETTINGS}
    Open Application    ${APPIUM_URL}    &{SETTINGS}

Clear screen and stop the app
    Click element    accessibility_id=C
    Close Application