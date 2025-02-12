*** Variables ***
&{DEVICE}      automationName=uiautomator2
...            platformName=android
...            platformVersion=13.0
...            deviceName=Pixel_7_API_33
# if udid is hardcoded, deviceName is and platformVersion will be ignored if they do not agree
# udid can be empty for an emulator, and it is safer that way, to ensure correct emulator is used
...            udid=
...            appium_port=4723