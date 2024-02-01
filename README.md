# Robocon 2024

## Introduction

This is a document for the 2024 Robocon Mobile application testing workshop. All participants are requested to follow the instructions to set up a development environment. Installing is a task that can take some time. However, if all of you, dear participants, come prepared, we will be able to start working on more interesting topics!

If you have trouble with the instructions, or would like to approach the topic differently, please contact us via email or workshop Slack channel.

## Table of contents
<!-- TOC -->
* [Robocon 2024](#robocon-2024)
  * [Introduction](#introduction)
  * [Table of contents](#table-of-contents)
* [Install instructions](#install-instructions)
  * [Step 0. Download Android SDK and its tools](#step-0-download-android-sdk-and-its-tools)
  * [Step 1. Get Appium Doctor to work (in virtual environments)](#step-1-get-appium-doctor-to-work-in-virtual-environments)
    * [Create a python virtual environment](#create-a-python-virtual-environment)
    * [Create a nodeJS virtual environment](#create-a-nodejs-virtual-environment)
  * [Step 2. Set up everything else for Android](#step-2-set-up-everything-else-for-android)
    * [Java 8](#java-8)
    * [bundletool jar](#bundletool-jar)
    * [ffmpeg](#ffmpeg)
    * [GStreamer tools](#gstreamer-tools)
  * [Step 3. Android setup summary and environment check](#step-3-android-setup-summary-and-environment-check)
  * [Step 4. Testing with physical Android phones](#step-4-testing-with-physical-android-phones)
  * [Step 5. Software for UI inspections](#step-5-software-for-ui-inspections)
  * [Step 6. Setup for iOS development (macOS only)](#step-6-setup-for-ios-development-macos-only)
* [Final notes](#final-notes)
<!-- TOC -->

# Install instructions
In the instructions we will make changes to the `${PATH}` variable.  Keep track of what you do to it!

## Step 0. Download Android SDK and its tools
Make sure that you have the newest Android Studio with Android SDK downloaded, and installed. Note that it is not enough to download the zips, you also need to unpack them and use the SDK Manager to download binary tools as well as system image(s). You may require about 6-10GB of space.

Visit https://developer.android.com/studio and download a copy of Android Studio Hedgehog. If you have an older copy, please get the newest one.

<details><summary>
Open this section to follow the screenshots and see what you need to download in Android Studio.</summary>

![SDK Manager in Android Studio Settings](./pics/Android_studio_ide_1.png)
![SDK Manager in Android Studio Settings](./pics/Android_studio_ide_2.png)
![SDK Manager in Android Studio Settings](./pics/Android_studio_ide_3.png)
![SDK Manager in Android Studio Settings](./pics/Android_studio_ide_4.png)

</details>

Downloading Android Studio (or Android SDK) also requires setting variable `${ANDROID_HOME}`. If you used Android Studio to set up Android SDK for you, take the path that the SDK Manager is listing in the field marked by red text in the screenshots.

To check the variable is not empty run:
```bash
echo ${ANDROID_HOME}
```

Based on that `${ANDROID_HOME}` variable, you will have to modify the `${PATH}`:
```bash
export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/platform-tools
```
These three paths are necessary for easy access to the tools.
Note that the folder structure of an older Android SDK may be different. If your SDK contains folder `tools/`, you should add it to the `${PATH}` in the same manner.

## Step 1. Get Appium Doctor to work (in virtual environments)
You need to be able to execute Robot Framework, Appium, and Appium Doctor from the command line, ideally from isolated virtual environments.

For that you will need to have in your system Python 3 with pip, wheel, virtualenv (not venv), as well as Node.js with npm.

Check what you have with the following commands:
```bash
python3 --version
python3 -m pip --version
python3 -m pip show virtualenv
python3 -m pip show wheel
node --version
npm --version
```
You need python _>=3.8_ and node _>=16.13.0_. Note that stable newest release is best to use. If in doubt, upgrade.
If you are missing these tools, please use the official instructions on how to install them on your operating system. We have not tried to use `pipx` to install the python tools, so we cannot recommend it.

- https://www.python.org/
- https://pypi.org/project/wheel/
- https://virtualenv.pypa.io/en/latest/installation.html
- https://nodejs.org/en/download

### Create a python virtual environment
Create environment with your preferred name (in the example it's `python-env`). Activate it. Check that pip in use is that of the virtual environment.
```bash
python3 -m virtualenv python-env
source python-env/bin/activate
which pip
pip install -r requirements.txt
```
Install the necessary Robot packages from requirements.txt, along with `nodeenv` we will use to create a virtual environment for Node.js.

_Do not deactivate the python virtual environment!_

### Create a nodeJS virtual environment
In the same terminal, create a Node.js environment with your preferred name (in the example it's `node-env`). Activate it, and check that npm in use is that of the virtual environment.
```bash
nodeenv node-env
source node-env/bin/activate
which npm
```
Install the necessary Node.js packages. Note that if newest Appium does not work for you, you can try downgrading it (from _2.4.1_ to _2.4.0_).
```bash
npm install -g appium
npm install -g mjpeg-consumer
```
At this point you should have two virtual environments enabled at the same time. _Keep them both active!_

If you are having problems with `nodeenv`, check out [Further reading](./further-reading.md) document.

## Step 2. Set up everything else for Android
You should be able to run Appium Doctor now!

Make sure you have Appium's UiAutomator2 driver installed. Then execute Appium Doctor with for this driver. The output of this command will `WARN` you if you are still missing something.
```bash
appium driver install uiautomator2
appium driver doctor uiautomator2
```
Read Appium Doctor's output. Below we list some of the issues you will have to resolve in your system, and how to do it neatly.

### Java 8
Both old and new Android version work with Java 8. Read more on the topic [here](./further-reading.md). We do not recommend installing it system-wide. You can download, unzip, and make it work locally in a terminal via changes to the `${PATH}` and `${JAVA_HOME}` variables.

You can download Adoptium Temurin Java 8 from https://adoptium.net/marketplace/?os=any&version=8 

Note that if you cannot find Java 8 in the list, check if your system is supported https://adoptium.net/supported-platforms/ and if it is not, switch to Java 11.

With `export` set the unzipped Java 8 directory as `${JAVA_HOME}`. Add the `/bin` inside it at the beginning of your `${PATH}` to make it take precedence over system-wide Java. Check that it works.
```bash
export JAVA_HOME=/your-java8-absolute-path
echo ${JAVA_HOME}
export PATH=${JAVA_HOME}/bin:${PATH}
java -version
```
Make sure that when you run any Android SDK commands, you do it always with the same version of Java!

When you execute `adb` (Android Debug Bridge) commands, an adb server will be started, and stay running in the background. Java version running that server has to match the Java used for other `adb` command calls.

### bundletool jar
Download the latest bundletool from https://github.com/google/bundletool/releases/ (currently it should be _1.15.6_). You will need to add it to the `${PATH}` for Appium.
Note that Appium looks for `bundletool.jar`.

You can rename the file, or keep the original (so you can still see the version), but create a soft-link to it. You also need to make it executable.
```bash
ln -s bundletool-all-1.15.6.jar bundletool.jar
chmod ug+x bundletool-all-1.15.6.jar
```

### ffmpeg
This is a necessary system-wide installation. Use official instructions from https://ffmpeg.org/download.html

### GStreamer tools
This is a necessary system-wide installation. Use the instructions linked by Appium Doctor.

## Step 3. Android setup summary and environment check
When you are done with the last step, you should have two virtual environments enabled (changing your `${PATH}`), and the following manually-added directories in your `${PATH}` variable:
- absolute path to Java 8's JDK and JRE binaries
- absolute path to a folder containing `bundletool.jar` or a link to it
- Android SDK subdirectory `cmdline-tools/latest/bin`
- Android SDK subdirectory `emulator`
- Android SDK subdirectory `platform-tools`

Re-run Appium Doctor. Check that there are no WARN messages anymore in the output.
```bash
appium driver doctor uiautomator2
```
## Step 4. Testing with physical Android phones
We instruct you to download an emulator image, and we will test mostly with them. However, you can (and should try to) run tests on actual Android phones.

On macOS, no additional setup is needed.

On Windows, you may have to install drivers according to documentation https://developer.android.com/studio/run/oem-usb

On Linux, connecting an Android smartphone does not make it immediately usable for Android SDK. You need to add udev rules. Use the udev rules from this repository:
https://github.com/M0Rf30/android-udev-rules
and make sure your user is part of the `plugdev` and `adbusers` groups.

## Step 5. Software for UI inspections
Get an executable of the newest version of Appium Inspector from https://github.com/appium/appium-inspector/releases

This is the primary inspector we will use. We will have a look also at UIAutomatorViewer (which seems to be gone from the newest version of Android SDK) for Android, and Xcode Inspector for iOS.

## Step 6. Setup for iOS development (macOS only)
These instructions assume you have done all the steps for the Android side. We will re-use the virtual environments.

Make sure you have both python and nodeenv virtual environments activated. Use the following command to install and run the iOS driver for Appium:
```bash
appium driver install xcuitest
appium driver doctor xcuitest
```
Read the output of Appium Doctor for `xcuitest` driver. Follow the instructions to set up Xcode.

You will have to download Apple's Xcode, and might need to set up a developer account to achieve that.

Check that you can use an iOS simulator. Run the following command:
```bash
xcrun simctl
```
If the command is ok, it should print command's help text for you. If something is wrong, it should print an error.

# Final notes
Please keep using output of the `appium driver doctor <driver>` commands to verify your environment. If the output is clean, and your python environment is ok, you should be good to go.

We recommend you create your own way to swiftly enable both virtual environments, one after another. This will be useful for both Android and iOS. For Android, you will need also changes to `${PATH}` (summarised in Step 3.).

If you would like to get further clarifications, you can refer to the [Further reading](./further-reading.md) document.
