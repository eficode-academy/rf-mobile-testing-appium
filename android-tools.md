# Android Debug Bridge
Under normal operation, Android devices (both physical and emulated), can be controlled with `adb`.

## Basic usage
When you execute `adb` first time, an adb server will be started, and it will keep running in the background. After that you can run `adb` commands from any terminal. Java version running that server should match the Java used for other `adb` command calls.

If you want to have control over when the server is started and killed, you can use the following commands:
```bash
adb start-server
adb kill-server
```
You can list all available devices (running emulators, and phones connected via USB) without details, or with more information:
```bash
adb devices
adb devices -l
```
To only list physical devices:
```bash
adb -d devices
```
Physical phones have names (like "Pixel 7a") and Unique Device IDs (like "2D342JFKN23826"). Use UDIDs to address it directly with `adb`. To find out if a specific device is connected use:
```bash
adb devices | grep -c ${UDID}
```
Note that sometimes a device can be connected, but it is not authorised for usage. The tests will fail, as ADB won't be able to command the device. Check for that with:
```bash
adb devices | grep -c ${UDID} | grep -c "unauthorized"
```

## Managing applications on device
List all applications installed on the selected phone:
```bash
adb -s ${UDID} shell pm list packages
```
If an old version of your app is installed, you may be better to remove it first, and them re-install it. Some Androids will skip apk install, if the app exist on the device in the same version. You need to know the full package name to run the uninstall command against it.
```bash
adb -s ${UDID} uninstall "${APP_PACKAGE_NAME}"
```
Note that uninstalling does not necessarily remove application cache data. To remove them with ADB, you need the Android application to be compiled in `debug` mode. That will allow ADB access to the application cache by running as application:
```bash
adb -s ${UDID} shell run-as ${APP_PACKAGE_NAME} rm -rf /data/data/${APP_PACKAGE_NAME}/cache/*
```

Install an Android binary application (apk file) on a device
```bash
adb -s ${UDID} install "${APK_FILE_WITH_PATH}"
```

To get the version of installed application run:
```bash
adb -s ${UDID} shell dumpsys package ${APP_PACKAGE_NAME} | grep versionName
```

To find out what is the app package of the open application, and what is the activity visible on the device, you can inspect a dump from ADB:
```bash
adb -s ${UDID} shell "dumpsys window windows"
```

To find out name of the starting app activity, open the app and run the following command:
```bash
adb -s ${UDID} shell logcat -d | grep 'START u0' | tail -n 1 | sed 's/.*cmp=\(.*\)} .*/\1/g'
```
Note that the printed name may contain `/`, but you should remove it before using it as an Appium parameter.

## More advanced usage
Get platform version of the device:
```bash
adb shell getprop ro.build.version.release
```
And same command using the `${UDID}` value:
```bash
adb -s ${UDID} shell getprop ro.build.version.release
```
When you boot a device, it may take time before it is ready to use. You can create your own script that waits for device to be ready for usage:
```bash
adb -s ${UDID} shell getprop sys.boot_completed
```
If you use a physical device, that has been turned on for some time, its device log is most likely full of events. Clear it before starting tests so the next time you try to extract the logs, only relevant information is in it:
```bash
adb -s ${UDID} logcat -c
```
Then, after your tests are over, you can dump the logs saved on the physical device with command. The `-d` parameter after `logcat` commands it to dump the logs, and exit. The `-b` parameter specifies what buffers to read from. The `default` here limits output to `main`, `system`, `crash`, but to get all buffers, you can use `all`. More on the topic can be found in [the official documentation](https://developer.android.com/tools/logcat).
```bash
adb -d -s ${UDID} logcat -d -b default > device_log.txt
```

## Android emulator start
Below is a simplified list of the commands. For full documentation please refer to https://developer.android.com/studio/run/emulator-commandline.html

To find out if you have any emulators you can run use
```bash
emulator -list-avds
```
When you have an emulator (created by hand of via SDK Manager), you can start it from the command line.
```bash
emulator -avd "${DEVICE_NAME}" -port ${EMULATOR_PORT}
```
Emulator has a permanent `${DEVICE_NAME}`, but it does not have a `${UDID}` until it is started. Starting the emulator, we can provide the `${EMULATOR_PORT}` number, that `emulator` program uses to make the `${UDID}` like this:
```bash
UDID=emulator-${EMULATOR_PORT}
```
There are many useful parameters you can use with the emulator command. For example:
```bash
emulator -avd "${DEVICE_NAME}" -port ${EMULATOR_PORT} -no-snapshot-save -logcat *:e > emulator.log 2>&1 &
```
`-no-snapshot-save`: emulators save state when they shut down. This means that if the test fails mid-way, the emulator could start next time into an open application. It is better make sure it has a "clean" state snapshot, and command it never to save the state.

`-no-snapshot-load`: alternative to never saving the snapshot is never loading it. However, this can significantly slow down the boot procedure, and increase waiting time.

`-logcat *:e`: configure the logs to list all messages of error level and higher. This can be replaced with other values, to adjust the log output.

`-logcat-output emulator.log` or `> emulator.log 2>&1` at the end ensures that the emulator logs are deposited into a file (here called `emulator.log`). Note that the `-logcat-output` parameter does not work correctly all Android SDK versions, thus the alternative with bash piping is provided.

We recommend hard-coding the `${EMULATOR_PORT}` value in the emulator configuration files. It will help you when you want to use more than one the same time (in multi-device tests, or in parallel executions in CI).

## Android emulator shutdown
After the tests are done, emulator can be shut down with:
```bash
adb -s ${UDID} emu kill
```
Note that emulator can take a while to shut down. Moreover, if the shutdown is incorrect or partial, processes or artifacts can remain, and prevent the start of the emulator next time.

One way to check that the emulator has shut down is to check for the following process:
```bash
ps aux | grerp qemu-system | grep "${DEVICE_NAME}"
```
Another artifact that can remain is the emulator lock file. In Linux, the lock file is stored in the following location:
```bash
file ${HOME}/.android/avd/${DEVICE_NAME}.avd/hardware-qemu.ini.lock
```
If you are confident that the emulator is not running, you can delete the lock file.

## SDK Manager
Android SDK can be managed from the command line by SDK Manager. It can replace Android Studio in many ways. It allows downloading and updating the SDK, its tools, and system images.

**Note**: the newest version of sdkmanager (as of February 2024) has to be executed with Java 17.

When dealing with Android SDK, users will be asked to accept licenses. To do that from the commandline execute:
```bash
sdkmanager --licenses
```
To update Android SDK run:
```bash
sdkmanager --update
```
If `${ANDROID_HOME}` is not set, or there are multiple Android SDK copies available, pass the value to `sdkmanager` like this:
```bash
sdkmanager --sdk_root=${ANDROID_HOME} --update
```
List what can be downloaded:
```bash
sdkmanager --list
```
You can list one or multiple items to install. Here are some of the tools used above:
```bash
sdkmanager --install "emulator" "platform-tools" "cmdline-tools;latest"
```
Android APIs, build tools, and platform-specific tooling can be installed by version:
```bash
sdkmanager --install "build-tools;34.0.0" "platforms;android-34" "sources;android-34"
```
Lastly, you can download a wide selection of Android system images.
Note that a lot of those version-specific installs could be parametrized and conducted automatically, as different packages keep the same naming scheme:

`system-images` ; `android-` API number ; image type ; architecture

Image type specifies the type of Android. It could be a phone image with or without Google services, but also it could be another device type. Some examples: `default`, `google_apis`, `google-tv`.

Architecture is important both for the Android emulator, and for the host device. Host and emulator architectures have to match to some degree, or the emulator won't start. Some examples: `x86`, `x86_64`, `arm64-v8a`.

You can download different kinds of images for the same Android API, to test with them:
```bash
sdkmanager --install "system-images;android-34;google_apis;x86_64" "system-images;android-34;default;x86_64" "system-images;android-34;default;arm64-v8a " "system-images;android-34;aosp_atd;x86_64"
```
 Or you could make download different API versions of the same kind of image:
```bash
sdkmanager --install "system-images;android-33;default;x86_64" "system-images;android-34;default;x86_64"
```
