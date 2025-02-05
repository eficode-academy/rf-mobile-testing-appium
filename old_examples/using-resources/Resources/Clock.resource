*** Variables ***
${APP_PACKAGE}    com.google.android.deskclock
${APP_ACTIVITY}    com.android.deskclock.DeskClock

${ID}    ${APP_PACKAGE}:id/
${TAB_MENU_ALARM}    ${ID}tab_menu_alarm
${NEW_ALARM_BUTTON}    ${ID}fab
${CLOCK_FACE}    ${ID}material_clock_face
${CLOCK_13}   //android.view.ViewGroup[@resource-id="${ID}material_clock_face"]//android.widget.TextView[text()="13"]
${TIMEPICKER_INPUT_SWITCH}    ${ID}material_timepicker_mode_button
${MINUTE_INPUT}    ${ID}material_minute_text_input
${OK_BUTTON}    ${ID}material_timepicker_ok_button
