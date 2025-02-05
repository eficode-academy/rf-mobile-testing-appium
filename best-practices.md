# How to write good mobile tests

## Don't repeat yourself
Make high level test cases that are platform-independent. If your test applications have (or should have) same user flow, then tests can and should reflect that. Leave minor differences to lower-level keywords.

Avoid platform-specific code in keyword implementations. Find ways to write keywords that can run on any platform. When differences are significant, create matching keywords, that do the same operation, and make no difference to the test flow.

Element locators on iOS and Android differ significantly. Avoid hard-coding them, and use variables instead. Make sure that you have matching sets of locators targeting identical or corresponding elements on every platform.

## Any device should do
Even if you have just one test device, avoid hard-coding its parameters into the test code. Dynamic device assignment simplifies testing with a wide range of platforms and OS versions.

Store all test device information in one object during test execution. Start with creating a configuration file describing the device. It should be the source of truth for your test scripts, as well as setup and teardown operations. Import it in robot, and add any new information that emerges (dynamically identified screen size, alias, test execution language set by the tester).

In multi-device tests, make lists of device objects. In the tests, keep track of the current device, to simplify access to that device's variables.

To parallelize the device tests, keep a library of device configuration files. Hard-code values like Appium port, emulator port, emulator name. Ensure no ports or names repeat between the devices.