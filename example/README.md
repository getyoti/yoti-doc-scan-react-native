# Yoti IDV, Example

An example of how to run the react native wrapper of Yoti IDV for [Android](https://github.com/getyoti/yoti-doc-scan-android) and [iOS](https://github.com/getyoti/yoti-doc-scan-ios).

## Prerequisites
To run this example, a working working React Native environment is needed (see [reactnative.dev/docs/getting-started](https://reactnative.dev/docs/getting-started)).

## Installation
Install the wrapper's dependencies by running `yarn install` from the `example` directory, and then proceed to the relevant platform section below.

### Android
To continue your installation with Android, you should run `yarn start` and `adb -s DEVICE_ID_HERE reverse tcp:8081 tcp:8081` (or `adb reverse tcp:8081 tcp:8081` if using an emulator) from the `example` directory. , and then open the `example/android` project in Android Studio. You can now sync Gradle and build the app.

### iOS
To continue your installation with iOS, you should run `pod install` from the `example/ios` directory, and then open the project in Xcode through the `Demo.xcworkspace` file.
