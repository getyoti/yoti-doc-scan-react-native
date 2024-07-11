# Yoti IDV, React Native

[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/getyoti/yoti-doc-scan-react-native?label=latest%20release)](https://github.com/getyoti/yoti-doc-scan-react-native/releases)
[![Publish Release](https://github.com/getyoti/yoti-doc-scan-react-native/workflows/Publish%20Release/badge.svg)](https://github.com/getyoti/yoti-doc-scan-react-native/actions?query=workflow%3A%22Publish+Release%22)
![Illustration](./Illustration.png)

A react native wrapper of Yoti IDV for [Android](https://github.com/getyoti/yoti-doc-scan-android) and [iOS](https://github.com/getyoti/yoti-doc-scan-ios). Yoti IDV allows a user of your app to take a photo of their document, as well as to scan or capture their face, we then verify this instantly and prepare a response, which your system can then retrieve on your hosted site.

## Prerequisites
To integrate with Yoti IDV, a working infrastructure is needed (see [developers.yoti.com](https://developers.yoti.com/identity-verification/overview) for more details or get in touch with us [here](https://developers.yoti.com/support)).

## Requirements
- [Android SDK 3+](https://github.com/getyoti/yoti-doc-scan-android/releases)
- [iOS SDK 5+](https://github.com/getyoti/yoti-doc-scan-ios/releases)

## Integration
Start your integration by adding the following dependency to your `package.json` file:
```json
"dependencies": {
    "@getyoti/yoti-doc-scan-react-native": "^3.0.0"
}
```

### Android
Continuing with your integration for Android, add the following property and repository to your project's [`build.gradle`](https://developer.android.com/build#build-files) file:
```groovy
buildscript {
    ext {
        yotiSdkVersion = "3.4.0"
    }
}
allprojects {
    repositories {
        maven {
            url 'https://maven.microblink.com'
        }
    }
}
```
Now add any of these optional dependencies to your app's [`build.gradle`](https://developer.android.com/build#build-files) file:
```groovy
dependencies {
    // With automatic capture via OCR and NFC capture
    implementation "com.yoti.mobile.android.sdk:yoti-sdk-doc-scan:${rootProject.ext.yotiSdkVersion}"
    // With manual capture only, no OCR, no NFC - around 14Mb smaller in size
    implementation "com.yoti.mobile.android.sdk:yoti-sdk-doc-scan-slim:${rootProject.ext.yotiSdkVersion}"
    implementation "com.yoti.mobile.android.sdk:yoti-sdk-doc-scan-sup:${rootProject.ext.yotiSdkVersion}"
    implementation "com.yoti.mobile.android.sdk:yoti-sdk-liveness-zoom:${rootProject.ext.yotiSdkVersion}"
    // With embedded AI model
    implementation "com.yoti.mobile.android.sdk:yoti-sdk-facecapture:${rootProject.ext.yotiSdkVersion}"
     // Without embedded AI model - around 20 MB smaller in size
    implementation "com.yoti.mobile.android.sdk:yoti-sdk-facecapture-unbundled:${rootProject.ext.yotiSdkVersion}"
}
```
If you're using Proguard or another obfuscation tool, you should also add the following configuration rules to your `proguard-rules.pro` file:
```groovy
-keep class com.yoti.** { *; }
-keep class com.microblink.** { *; }
-keep class com.microblink.**$* { *; }
-dontwarn com.microblink.**
-keep class com.facetec.zoom.** { *; }
-dontwarn javax.annotation.Nullable
```

### iOS
To continue your integration with iOS, you should add the following to your [`Podfile`](https://guides.cocoapods.org/using/the-podfile.html) and run `pod install` from its directory:
```bash
require_relative '../node_modules/@react-native-community/cli-platform-ios/native_modules'
require_relative '../node_modules/react-native/scripts/react_native_pods'

platform :ios, '11.0'

target 'TargetName' do
  config = use_native_modules!
  use_react_native!(:path => config[:reactNativePath])
  use_frameworks!
  use_native_modules!
  pod 'YotiDocumentScan'                // Include if `YotiSDKIdentityDocument` is included and to support identity document OCR
  pod 'YotiNFC'                         // Include if `YotiSDKIdentityDocument` is included and to support identity document NFC
  pod 'YotiSDKIdentityDocument'         // Optional
  pod 'YotiSDKSupplementaryDocument'    // Optional
  pod 'YotiSDKFaceTec'                  // Optional
  pod 'YotiSDKFaceCapture'              // Optional
end
```
In addition, you should add [`NSCameraUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nscamerausagedescription) to your `Info.plist`.

And if you have included `YotiNFC` in your target, make sure to also:
- Add [`NFCReaderUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nfcreaderusagedescription) to your `Info.plist`
- Add [`com.apple.developer.nfc.readersession.iso7816.select-identifiers`](https://developer.apple.com/documentation/bundleresources/information_property_list/select-identifiers) to your `Info.plist` and include [`A0000002471001`](https://www.icao.int/publications/Documents/9303_p10_cons_en.pdf) as an application identifier for your app to support
- Turn on [`Near Field Communication Tag Reading`](https://developer.apple.com/documentation/corenfc/building_an_nfc_tag-reader_app) under the Signing & Capabilities tab for your project’s target

## Usage
### 1. Import module
```javascript
import RNYotiDocScan from '@getyoti/yoti-doc-scan-react-native';
```
### 2. Launch a session
Launch a session with its required parameters using the `startSession` function.
```javascript
const successCallback = (code, description) => {
    ...
}
const errorCallback = (code, description) => {
    ...
}
RNYotiDocScan.startSession(id, token, successCallback, errorCallback);
```

### 3. Customizations
On iOS, you can set the primary color using the following API:
```javascript
RNYotiDocScan.setPrimaryColorRGB(0, 0, 0); // default: (40, 117, 188)
```
To customize the colors on Android, please refer to its separate [documentation](https://github.com/getyoti/yoti-doc-scan-android#colours).

In addition, you can choose to also specify a request code on Android:
```javascript
RNYotiDocScan.setRequestCode(0); // default: 9001
```

## Supported languages
Yoti IDV supports the 9 languages listed in the table below, but their use is driven by the localization configuration of your target. If your target only supports a subset of our SDK's supported languages, our SDK will fall back to English on the ones your target doesn't support.

Language | Code
:-- | :--
Arabic | ar
Dutch | nl
English (default) | en
French | fr
German | de
Italian | it
Russian | ru
Spanish | es
Turkish | tr

## Error codes
Code | Description
:-- | :--
1000 | No error occurred. The user cancelled the session
2000 | Unauthorised request (wrong or expired session token)
2001 | Session not found
2002 | Session expired
2003 | SDK launched without a session token
2004 | SDK launched without a session id
3000 | Yoti's services are down or unable to process the request
3001 | An error occurred during a network request
3002 | The user did not have a network connection
3003 | A network request timed out
4000 | The user did not grant permission to the camera
4001 | The user submitted a wrong document
5000 | The user's camera was not found and file upload is not allowed
5002 | No more local tries for the liveness flow
5003 | SDK is out-of-date, please update the SDK to the latest version
5004 | An unexpected internal error occurred
5005 | An unexpected document capture error occurred
5006 | An unexpected liveness capture error occurred
5008 | An unsupported configuration was used
6000 | The identity document dependency could not be found
6001 | The face scan dependency could not be found
6002 | The supplementary document dependency could not be found
6003 | The face capture dependency could not be found
7000 | The user did not have the required documents

## Support
For any questions or support please contact us [here](https://support.yoti.com). Once we have answered your question, we may contact you again to discuss Yoti products and services. If you'd prefer us not to do this, please let us know when you e-mail.

## Licence
See the licence [here](https://www.yoti.com/terms/identity-verification).
