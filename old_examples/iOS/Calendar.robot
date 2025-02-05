*** Variables ***
# app-related variables
${APP}         com.apple.mobilecal
${LOCALE}      US
${LANGUAGE}    en-US

# Locators for the native iOS Calendar app
${ADD_BUTTON}      id=Add
${TITLE_FIELD}     id=Title
# As you can tell locators are quite bad in the native Calendar app, they're mostly just i18n strings.
# This is why setting locale and language is important for the test to pass
${ALLDAY_CHECKBOX}    //XCUIElementTypeSwitch[@name="All-day"]
${DELETE_EVENT}    //XCUIElementTypeStaticText[@name="Delete Event"]
${DELETE_EVENT_BUTTON}    //XCUIElementTypeButton[@name="Delete Event"]
${DELETE_CONFIRM}    //XCUIElementTypeStaticText[@name="Are you sure you want to delete this event?"]