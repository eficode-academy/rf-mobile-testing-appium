# Further reading
<!-- TOC -->
* [Further reading](#further-reading)
  * [Additional remarks on the installation instructions](#additional-remarks-on-the-installation-instructions)
* [Q&A](#qa)
  * [Can I use an older version of Appium?](#can-i-use-an-older-version-of-appium)
  * [Why use python virtualenv, and not venv?](#why-use-python-virtualenv-and-not-venv)
  * [Why should we use nodeenv?](#why-should-we-use-nodeenv)
    * [Have you tried another Node.js tool instead?](#have-you-tried-another-nodejs-tool-instead)
  * [What should I do if I cannot get nodeenv to work?](#what-should-i-do-if-i-cannot-get-nodeenv-to-work)
    * [Install with npm prefix](#install-with-npm-prefix)
    * [Install locally in node_modules and run with npm](#install-locally-in-node_modules-and-run-with-npm)
  * [What about Java 8?](#what-about-java-8)
  * [Why are we not using Docker or virtual machines?](#why-are-we-not-using-docker-or-virtual-machines)
    * [USB device's connection to inside of Docker and VMs is imperfect](#usb-devices-connection-to-inside-of-docker-and-vms-is-imperfect)
    * [Android emulators won't run in every virtual machine or Docker container](#android-emulators-wont-run-in-every-virtual-machine-or-docker-container)
<!-- TOC -->

## Additional remarks on the installation instructions
Docker and virtual machines are convenient for many development environments, but they fall short in mobile context. However, we still want to create and use environments that do not interfere with the regular operation of your machine, and let you test out different versions of Appium or Robot easily. This is why in workshop instructions, we suggest usage of the next best thing: a combination of virtual environments (python, and python-style) and changes to the `${PATH}` variable in your terminal.

Only macOS users can do testing with iOS. That's due to Apple's restrictions. This is why the workshop focuses on Android, so everyone can join. Later part of the workshop will address the topic of doing testing on both Android and iOS, neatly and easily, so even non-Mac users can follow.

# Q&A
## Can I use an older version of Appium?
We strongly recommend you to follow the instructions to create an environment with new Appium. You can follow same instructions and create another environment with old Appium. Virtual environments can be activated separately, so you can use both old and new Appium.

In this training we want to use the newest stable Appium, as there may be significant changes. For example, since the release of 2.0, there are breaking changes in how Appium can be used. We see no benefit in teaching how to use older versions of Appium.

The largest change in Appium 2.0 is that drivers are now installed and managed separately from Appium's version. This means you can find a specific version(s) of driver(s) that work in your setup(s), and keep using them, regardless of Appium's binary. However, you have to control the `${APPIUM_HOME}` directory, in order to be able to use more than one version of a given Appium driver.

Keep also in mind that Appium's drivers are the pieces that interact with Android SDK and Xcode. This means that when Google or Apple release updates breaking their own APIs, Appium can also break. Moreover, when Appium is updated to catch up to those new APIs, it could break old driver functionality. This is where having multiple virtual environments helps testing your tooling.

## Why use python virtualenv, and not venv?
Both `venv` and `virtualenv` are endorsed by the official Python documentation.
We recommend using virtualenv only because `nodeenv` is built on top of `virtualenv`, and integrates better into it. It does require installing `virtualenv` separately (opposite to `venv` which is built-in). There should be no other differences. If you do have problems with `virtualenv`, you can switch to `venv`. You may want to set up your node using [prefixes](#install-with-npm-prefix) instead of `nodeenv`.

## Why should we use nodeenv?
Usually npm can be used to install and set up a local development directory. However, we are not developing with Node.js. We need to install Appium as a global npm package, so it gets installed as a binary we can use from the command line.

If you install Appium globally in the system, you will have difficulty switching versions. We have found that to be troubling when we had to update. In cases of updates as massive as Appium 1 to Appium 2, where a lot of functionality changes, updating a global package brings risks and is quite problematic. Switching the virtual environment you use for a moment is much easier.

So what we want is something like a virtual environment, where we can control the version of Node.js as well as install packages "globally". For Node.js there are multiple options. In last few weeks we checked them, and `nodeenv` seemed to work the best - at least on Linux.


### Have you tried another Node.js tool instead?
We have tested `nave`. It looks like it works, but at closer inspection, in bash on Linux it makes a mess of the `${PATH}` variable. We found it could not properly "deactivate" itself. We cannot recommend it.

Another two tools `nvm` and `nodenv` are mainly made for changing the version of Node.js. They do not create an environment to install and run globally installed packages.

We have found also `npx`, but we do not recommend it, as it seems to be made for a different use-case.

## What should I do if I cannot get nodeenv to work?
Here are 2 alternative ways to install and use Appium, that we found to work.

### Install with npm prefix
If you cannot get nodeenv to work, the next best thing would be to try using prefixes. This will not let you change the Node.js version you are using, but it will allow you to install "globally" into a separate directory. You will have to add that directory to your `${PATH}`, just like with Java.

Create a variable to store info where you install Appium. Then install it, add the directory to `${PATH}`, and check that it works.
```bash
export APPIUM_DIR=/absolute-path-to-directory
npm install -g --prefix ${APPIUM_DIR} appium
export PATH=${APPIUM_DIR}/bin:${PATH}
which appium
```
Note that the downside to this solution is that you can only use the system-wide version of Node.js. If you want, you can use `nvm` for that.

### Install locally in node_modules and run with npm
Appium documentation recommends installing it globally. If you install it locally, it will be added to a `node_modules` folder inside project root, but it will not be part of the `${PATH}`. However, you can use `npm` commands to start Appium server. 

Start by creating a _package.json_ configuration file with Appium version.
```bash
npm init
npm install appium@2.15.0
```
Then manually edit the _package.json_ file to include run scripts, like:
```json
"scripts": {
  "start": "appium",
  "install:android": "appium driver install uiautomator2",
  "test": "appium driver doctor uiautomator2",
  "env": "echo ${PATH}"
},
```
Then you can use the scripts to run your scripts, that do the job of installing, drivers, and starting Appium server:
```bash
npm run install:android
npm test
npm start -- --log appium.log
```
Important thing to note in this solution is that it ties the current version of the project to a specific version of Appium. Trying out a different version of Appium may require a lot of work.

If you want to run your tests with another version of Appium, you will need to delete _node_modules_, update the _package.json_, install new versions of Appium and its drivers, run, delete _node_modules_, restore _package.json_, and install previous versions of Appium and drivers. 

## What about Java 8?
For this workshop, we set up new Java. However, for an unusually long time, Android development was done with Java 8. It is now hard to install it, as it is being removed from software repositories. Moreover, some modern software may not work well with it. You may be able to set it up, but it is safer to do it without a system-wide install, and switch between different Java versions as needed.

In Android app development, Java version and Android version are tied. If you set up Java 8, you will be able to build, run and test even a very old Android version. While those are not officially supported anymore, it is good to know in case you end up working with Android apps for legacy OS versions.

Let's review the history of Android versions and how they connect to Java version:

| Android version | API level | Java versions | Year released | Support    |
|-----------------|-----------|---------------|---------------|------------|
| 15              | 35        | 17, 11, 9, 8  | Q3 2024       | latest     |
| 14              | 34        | 17, 11, 9, 8  | Q4 2023       | maintained |
| 13              | 33        | 17, 11, 9, 8  | Q3 2022       | maintained |
| 12.1            | 32        | 11, 9, 8      | Q1 2022       | maintained |
| 12              | 31        | 11, 9, 8      | Q3 2021       | maintained |
| 11              | 30        | 11, 9, 8      | Q3 2020       | deprecated |
| 10              | 29        | 9, 8          | Q3 2019       | deprecated |
| 9               | 28        | 9, 8          | Q3 2018       | deprecated |
| 8.1             | 27        | 8             | Q4 2017       | deprecated |
| 8.0             | 26        | 8             | Q3 2017       | deprecated |
| 7.1-7.1.2       | 25        | 8             | Q4 2016       | deprecated |
| 7.0             | 24        | 8             | Q3 2016       | deprecated |

As you see, all Android version that still receive support can be used with Java 11, which is easier to install than Java 8. Still, keep in mind that [Global statcounter](https://gs.statcounter.com/android-version-market-share/mobile-tablet/worldwide/) shows that there's still plenty of devices running Android 10 and 9, and even some with Android 8.

Sources:
- https://en.wikipedia.org/wiki/Android_version_history
- https://developer.android.com/build/jdks
- https://stackoverflow.com/questions/54129834/which-android-versions-run-which-java-versions
- https://source.android.com/docs/setup/start/older-version

## Why are we not using Docker or virtual machines?
We have yet to manage to set up the full testing environment with Docker or virtual machines, that does not require any host setup. Biggest blocker is the device under test.

### USB device's connection to inside of Docker and VMs is imperfect
Docker and virtual machines are isolated from hardware. This is a feature. Both Docker and virtual machine software enable us to share hardware with the inside of the machine, but it may be unreliable, especially on MacOS and Windows.

Second issue is that a physical Android phone connected via USB will also require `adb` authorisation between phone and the inside of the Docker container. Easiest way to establish it, is to share the `.android/` directory with `adbkeys` from the host. Which in turn means you have to establish it on the host, with `adb`. That defeats the purpose of the Docker container altogether.

### Android emulators won't run in every virtual machine or Docker container
Android emulators are actually virtual machines themselves. When you start an Android emulator, you use the virtualization capabilities of your hardware. This is easy if the emulator is executed on bare metal operating systems.

If you want to start an emulator inside a virtual machine or a Docker container, the host machine has to be capable of embedded virtualization. This is something that many personal computers cannot do: either the CPUs are not capable of it, or the GPU cannot provide support to the VM. So you need specialized hardware setup to make it possible. You can get it from the cloud providers, but it may be more challenging, even with on-prem servers.
