*** Variables ***
# example usage: ${${PLATFORM}_MENU_BUTTON}
# ${IOS_MENU_BUTTON}        locator
# ${ANDROID_MENU_BUTTON}    locator


${ANDROID_APP_PACKAGE}    com.google.android.deskclock
${ANDROID_APP_ACTIVITY}    com.android.deskclock.DeskClock
${ANDROID_ID}                  ${ANDROID_APP_PACKAGE}:id/

${ANDROID_TAB_MENU_ALARM}      ${ANDROID_ID}tab_menu_alarm
${ANDROID_NEW_ALARM_BUTTON}    ${ANDROID_ID}fab
${ANDROID_CLOCK_FACE}          ${ANDROID_ID}material_clock_face
${ANDROID_CLOCK_13}            //android.view.ViewGroup[@resource-id="${ANDROID_ID}material_clock_face"]//android.widget.TextView[text()="13"]
${ANDROID_TIMEPICKER_INPUT_SWITCH}    ${ANDROID_ID}material_timepicker_mode_button
${ANDROID_MINUTE_INPUT}        ${ANDROID_ID}material_minute_text_input
${ANDROID_OK_BUTTON}           ${ANDROID_ID}material_timepicker_ok_button

${IOS_TAB_MENU_ALARM}      ios-locator-missing
${IOS_NEW_ALARM_BUTTON}    ios-locator-missing
${IOS_CLOCK_FACE}          ios-locator-missing
${IOS_CLOCK_13}            ios-locator-missing
${IOS_TIMEPICKER_INPUT_SWITCH}    ios-locator-missing
${IOS_MINUTE_INPUT}        ios-locator-missing
${IOS_OK_BUTTON}           ios-locator-missing