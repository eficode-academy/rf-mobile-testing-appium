*** Variables ***
&{ANDROID_DEVICE}
...    automationName=uiautomator2
...    platformName=android
...    platformVersion=14.0
...    deviceName=Pixel_3_API_30
...    udid="insert_the_unique_device_id_here"
...    appiumPort=4773
# note that emulator udid is the name emulator was started with

&{IOS_DEVICE}
...    automationName=XCUITest
...    platformName=ios
...    platformVersion=14.3
...    deviceName="iPhoneSE"
...    udid="insert_the_unique_device_id_here"