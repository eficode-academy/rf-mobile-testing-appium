*** Settings ***
Library    AppiumLibrary

*** Test Cases ***
Add 7 and 9 in the calculator
    Open Application    http://localhost:4723
    ...    alias=android
    ...    automationName=uiautomator2
    ...    platformName=android
    ...    platformVersion=14.0
    ...    deviceName=Pixel_7_Pro_API_34
    ...    appPackage=bored.codebyk.mintcalc
    ...    appActivity=MainActivity

    Click element    accessibility_id=7
    Click element    accessibility_id=+
    Click element    accessibility_id=9
    Click element    accessibility_id==
    Element Should Contain Text    //android.widget.EditText    16
    Click element    accessibility_id=C
    Close Application