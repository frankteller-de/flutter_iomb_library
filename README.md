# Unoffical IOMb Flutter Library

[![Pub](https://img.shields.io/pub/v/flutter_iomb_library.svg)](https://pub.dartlang.org/packages/flutter_iomb_library)
[![Build Status](https://github.com/codeforce-dev/flutter_iomb_library/workflows/Dart/badge.svg)](https://github.com/codeforce-dev/flutter_iomb_library/actions)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/codeforce-dev/flutter_infonline_library/blob/main/LICENSE)
[![package publisher](https://img.shields.io/pub/publisher/path.svg)](https://pub.dev/publishers/codeforce.dev/packages)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true)]()

Library for census measurements

The IOMb Flutter Library supports the IOMb/Census (IOMb Library iOS/Android) measurement system.

If you are interested in pseudonym measurements look at [flutter\_infonline_library](https://github.com/codeforce-dev/flutter_infonline_library):

* IOMp/SZM (INFOnline Library iOS/Android)
* ÖWA (INFOnline Library iOS/Android)

## Requirements
- Dart sdk: `>=2.17.6 <4.0.0`
- Flutter: `>=2.5.0`
- Android: `minSdkVersion 19`
- iOS: `minSdkVersion 12`
- native iOS and Android INFOnline libraries

You will get the native iOS and Android libraries via email from INFOnline Support. The native libraries are not public!

## Configuration

Add `flutter_iomb_library` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

### iOS
Open ``ios/Podfile`` in your project. Make sure platform is uncommented and has a minimum version of 11.

```bash
platform :ios, '12.0'
```

Also in Podfile add pod package under use_frameworks.

```bash
target 'Runner' do
  use_frameworks!
  pod 'IOMbLibrary', :git => 'https://github.com/INFOnline-sg/libs-appsensor-iomb-ios.git'
end
```

### Android
Now open the ``android/app/build.gradle`` file and make sure your SDK version is >= 19.

```bash
android {
  defaultConfig {
    minSdkVersion 26
    targetSdkVersion 33
  }
}
```

Open the ``android/build.gradle`` and add the maven source. A GitHub classic PAT with read:packages permission should be provided.
```bash
allprojects {
  repositories {
  maven {
    url "https://maven.pkg.github.com/INFOnline-sg/libs-appsensor-iomb-android"

    credentials {
      username = project.findProperty("gpr.user") ?: System.getenv("GITHUB_USERNAME")
      password = project.findProperty("gpr.token") ?: System.getenv("GITHUB_TOKEN")
    }
  }
}
```

# Usage
Simple example to test the plugin in your project.
## Example

```dart
import 'package:flutter_iomb_library/flutter_iomb_library.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IombLibrary.instance.android.setDebugModeEnabled(true);
  await IombLibrary.instance.ios.setDebugLogLevel(IOMBDebugLevel.trace);

  await IombLibrary.instance.sessionConfiguration(
    baseURL: Platform.isAndroid ? '<yourAndroidBaseURL>' : '<yourIosBaseURL>',
    offerIdentifier: Platform.isAndroid ? '<AndroidIdentifier>' : '<iOSIdentifier>',
  );

  await IombLibrary.instance.logViewEvent(
    type: IOMBViewEvent.appeared,
    category: '<yourCategory>'
  );
}
```

# Supported functions

## Shared for all platforms
```dart
IombLibrary.instance.sessionConfiguration(
	baseURL: '<yourBaseURL>',
	offerIdentifier: '<yourIdentifier>',
);

IombLibrary.instance.logViewEvent(type: IOMBViewEvent.appeared, category: '<category>');

IombLibrary.instance.terminateSession();
```
For more informations look at the offical [iOS](https://docs.infonline.de/infonline-measurement/en/integration/lib/iOS/IOMbLib_iOS_Interface_API/) and [Android documentation](https://docs.infonline.de/infonline-measurement/integration/lib/android/IOMbLib_Android_Interface_API/). 

## iOS specified
```dart
IombLibrary.instance.ios.setDebugLogLevel(IOMBDebugLevel.trace);
```
For more informations look at the offical [iOS documentation](https://docs.infonline.de/infonline-measurement/en/integration/lib/iOS/IOMbLib_iOS_Interface_API/). 

## Android specified
```dart
IombLibrary.instance.android.setDebugModeEnabled(true);
```
For more informations look at the offical [Android documentation](https://docs.infonline.de/infonline-measurement/integration/lib/android/IOMbLib_Android_Interface_API/). 
