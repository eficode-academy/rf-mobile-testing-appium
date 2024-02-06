*** Settings ***
Library    AppiumLibrary

Test Setup       Install And Open App
Test Teardown    Close Application

*** Test Cases ***
iOS Calendar POC
    # Simple POC to open calendar app, do 1 entry and then delete it.
    # As you can tell locators are quite bad in the native Calendar app, they're mostly just i18n strings.
    Wait and Click                        id=Add
    Wait Until Element Is Visible         id=Title
    Element Should Be Disabled            id=Add
    Input Text                            id=Title    Robot framework mobile testing workshop
    Click Element                         //XCUIElementTypeSwitch[@name="All-day"]
    Element Should Be Enabled             id=Add
    Click Element                         id=Add
    Wait and Click                        //XCUIElementTypeButton[@name="Today, Tuesday, February 6"]
    Wait and Click                        //XCUIElementTypeButton[@name="Robot framework mobile testing workshop, All day"]
    Wait and Click                        //XCUIElementTypeStaticText[@name="Delete Event"]
    Wait Until Element Is Visible         //XCUIElementTypeStaticText[@name="Are you sure you want to delete this event?"]
    Click Element                         //XCUIElementTypeButton[@name="Delete Event"]
    Wait and Click                        //XCUIElementTypeButton[@name="February"]
    Log To Console                        Done with POC


*** Keywords ***
Install And Open App
    # You find these details from started appium server and from your xcode simulator
    Open Application    http://0.0.0.0:4723
    ...                 automationName=xcuitest
    ...                 platformName=ios
    ...                 platformVersion='15.5'
    ...                 udid=4FCA4947-E0BB-4BE5-8454-66BEFE11BD16
    ...                 app=com.apple.mobilecal
    ...                 wdaLocalPort=8101
    ...                 locale=US
    ...                 language=en-US


Wait and Click
    [Arguments]     ${locator}
    Wait Until Element Is Visible         ${locator}
    Click Element                         ${locator}
