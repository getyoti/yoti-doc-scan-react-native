![YotiBanner](./yoti_banner.png)

# Yoti Doc Scan SDK for React Native

[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/getyoti/yoti-doc-scan-react-native?label=latest%20release)](https://github.com/getyoti/yoti-doc-scan-react-native/releases) [![Publish Release](https://github.com/getyoti/yoti-doc-scan-react-native/workflows/Publish%20Release/badge.svg)](https://github.com/getyoti/yoti-doc-scan-react-native/actions?query=workflow%3A%22Publish+Release%22)

Yoti is an identity checking platform that allows organisations to verify who people are, online and in person. The Yoti Doc Scan SDK allows the user to take a photo of their identifying document which we verify instantly and prepare a response which your system can then retrieve. Further information can be found in the [documentation](https://developers.yoti.com/yoti/getting-started-docscan).

## Prerequisites

A supporting Yoti Doc Scan SDK backend installation is required. Learn more about the backend SDK in the [Getting Started guide](https://developers.yoti.com/yoti/getting-started-docscan).

## React Native >= 0.60.0 installation

`yarn add @getyoti/react-native-yoti-doc-scan`

Navigate to your iOS folder and update pods with:

`pod install`

React Native autolinking will handle the rest of the native configuration. Should autolinking fail, consult the [troubleshooting instructions](#troubleshooting).

## React Native 0.59.x installation

Install the library with:

`yarn add @getyoti/react-native-yoti-doc-scan`

Link the library:

`react-native link @getyoti/react-native-yoti-doc-scan`

If you're using CocoaPods, navigate to your `ios` and update your `Podfile`:

```diff
  pod 'Folly', :podspec => '../node_modules/react-native/third-party-podspecs/Folly.podspec'
+ `pod 'react-native-yoti-doc-scan', :path => '../node_modules/react-native-yoti-doc-scan/react-native-yoti-doc-scan.podspec'`
end
```

And then your pods with:

`pod install`

If autolinking fails, refer to the [troubleshooting instructions](#troubleshooting).

## Android configuration

### Microblink

Add microblink to your repositories in the root build.gradle file (`android/build.gradle`):

```groovy
allprojects {
    repositories {
        mavenCentral()
        maven { url 'https://maven.microblink.com' }
        maven { url "https://jitpack.io" }
        ...
    }
    ...
}
```
### Debug build configuration

Add this configuration for the debug build type to your `buildTypes` block (`android/app/build.gradle`):

```groovy
buildTypes {
    debug {
        matchingFallbacks = ['release']
      ...
    }
    ...
}

```
If you're using [Firebase Performance Monitoring](https://rnfirebase.io/perf/usage) you'll need to disable it for debug built variant. One way to do this is including this flag in your `gradle.properties` file:

```groovy
firebasePerformanceInstrumentationEnabled=false

```
And update your release build command line to enable it:

```groovy
./gradlew assembleRelease -PfirebasePerformanceInstrumentationEnabled=true

```

### Release build configuration
If you're using **Proguard** or other obfuscation tool, add the following configuration rules to your proguard-rules.pro file:
```groovy
-keep class com.yoti.** { *; }
-keep class com.microblink.** { *; }
-keep class com.microblink.**$* { *; }
-dontwarn com.microblink.**
-keep class com.facetec.zoom.** { *; }
-dontwarn javax.annotation.Nullable
```


Depending on your Android project setup and version of React Native, you
may encounter the following error during your build process:

> More than one files produce libc++_shared.so

Resolve by adding the following packaging options to your `android` block (`android/app/build.gradle`):

```groovy
android {
    compileSdkVersion rootProject.ext.compileSdkVersion
    
    packagingOptions {
        pickFirst 'lib/x86/libc++_shared.so'
        pickFirst 'lib/x86_64/libjsc.so'
        pickFirst 'lib/arm64-v8a/libjsc.so'
        pickFirst 'lib/arm64-v8a/libc++_shared.so'
        pickFirst 'lib/x86_64/libc++_shared.so'
        pickFirst 'lib/armeabi-v7a/libc++_shared.so'
    }
    ...

```

# Usage

The SDK exposes a single method, `startSession()`, which handles communication between your app and the Yoti app on a user's device.

Import the SDK with:

```javascript
import YotiDocScan from '@getyoti/react-native-yoti-doc-scan;
```

Call the `startSession` method with your session Id and client session token. 
The method accepts two callbacks: one invoked on success and the other when the result is a failure.

```javascript
    function onSuccess (code, description) {
        // handle success scenario
    }
    function onError (code, description) {
        // handle error scenario
    }
    YotiDocScan.startSession(
        sessionId,
        clientSessionToken,
        onSuccess,
        onError
    );
  }}
```
Optionally, you can specify Android request code. If not, by default it is set to 9001:
```javascript
    YotiDocScan.setRequestCode(8888);
```

Your callbacks will receive a consistent response with two parameters: `code` (number) and `description` (string).
The `code` is always populated with one of the values in the results table below.
The `description` is not guaranteed to always have a value and as such your business logic should not rely on it.


| Code              | Message                      | Retry possible for the same session                    |
| ----------------- | ---------------------------- | ---------------------------------- |
| 0                 | Result with success          | No                                 |
| 1000              | No error occurred - the end-user cancelled the session for an unknown reason           | Yes |
| 2000              | Unauthorised request (wrong or expired session token)           | Yes |
| 2001              | Session not found           | Yes |
| 2003              | SDK launched without session Token           | Yes |
| 2004              | SDK launched without session ID           | Yes |
| 3000              | Yoti's services are down or unable to process the request           | Yes |
| 3001              | An error occurred during a network request          | Yes |
| 3002              | User has no network          | Yes |
| 4000              | The user did not grant permissions to the camera          | Yes |
| 5000              | No camera (when user's camera was not found and file upload is not allowed)          | No |
| 5002              | No more local tries for the liveness flow          | Yes |
| 5003              | SDK is out-of-date - please update the SDK to the latest version          | No |
| 5004              | Unexpected internal error          | No |
| 5005              | Unexpected document scanning error          | No |
| 5006              | Unexpected liveness error          | No |
| 6000              | Document Capture dependency not found error          | No |
| 6001              | Liveness Zoom dependency not found error          | No |
| 6002              | Supplementary document dependency not found error          | No |

## Troubleshooting

<details>
	<summary>Resolving autolinking failures on Android and iOS</summary>


### iOS

Linker errors pertaining to Swift libraries such as `swiftFoundation` can be resolved with one or more of the solutions mentioned [in this oft-quoted StackOverflow discussion](https://stackoverflow.com/questions/52536380/why-linker-link-static-libraries-with-errors-ios), depending on your React Native version and project setup.

### Android

Android linking is performed in 3 steps:

#### android/settings.gradle

Add the following to your settings.gradle file as a new entry before the last line which has `include ':app'`:

```groovy
    include ':react-native-yoti-doc-scan'
    project(':react-native-yoti-doc-scan').projectDir = new
    File(rootProject.projectDir, '../node_modules/react-native-yoti-doc-scan/src/android')

    include ':app'
```

#### android/app/build.gradle

Find the `dependencies` block in your build.gradle file and add `implementation project(':react-native-yoti-doc-scan')`:

```groovy
dependencies {
    ...
    implementation project(':react-native-yoti-doc-scan')
}
```


#### android/app/src/main/java/..../MainApplication.java

Add this import for the package:

```diff
import android.app.Application;
import com.facebook.react.ReactApplication;
+ import com.yoti.reactnative.RNYotiDocScanPackage;
```

Find the `getPackages` function and add `new RNYotiDocScanPackage()` to the list of packages.

```diff
@Override
protected List<ReactPackage> getPackages() {
    return Arrays.<ReactPackage>asList(
        new MainReactPackage(),
+       new RNYotiDocScanPackage(),
        ...
```

</details>

## Support
If you have any other questions please do not hesitate to contact sdksupport@yoti.com.
Once we have answered your question we may contact you again to discuss Yoti products and services. If you'd prefer us not to do this, please let us know when you e-mail.

## Licence
Please find the licence for the SDK [here](https://www.yoti.com/wp-content/uploads/2019/08/Yoti-Doc-Scan-SDK-Terms.pdf).
