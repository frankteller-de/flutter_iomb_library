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

Flutter >=3.44 / Dart >=3.12, Java 17, Android API 21+, and iOS 13+.
The consuming Flutter SDK may require higher OS versions (Flutter 3.47: API 24 / iOS 15).
The Dart API is unchanged; older Flutter projects must use the previous release line.
Examples use Flutter 3.47, AGP 9.1 / Gradle 9.3.1, and iOS 15.

## Configuration

### iOS

Swift Package Manager (default in Flutter 3.44+) and CocoaPods share the same Swift source.
SwiftPM resolves [IOMbLibrary 1.2.0](https://github.com/INFOnline-sg/libs-appsensor-iomb-ios), including its privacy manifest.
For CocoaPods, add this source inside the Runner target; remove it when this plugin uses SwiftPM to avoid linking the SDK twice:

```ruby
pod 'IOMbLibrary', :git => 'https://github.com/INFOnline-sg/libs-appsensor-iomb-ios.git', :tag => '1.2.0'
```

### Android

The plugin uses `de.infonline:iomb-library:1.1.2`. Add its repository to the app:

```groovy
maven {
    url 'https://maven.pkg.github.com/INFOnline-sg/libs-appsensor-iomb-android'
    credentials {
        username = project.findProperty('gpr.user') ?: System.getenv('GITHUB_USERNAME')
        password = project.findProperty('gpr.token') ?: System.getenv('GITHUB_TOKEN')
    }
    content { includeGroup('de.infonline') }
}
```

Keep credentials in user-level Gradle properties or environment variables; the token needs package-read access.
For Android below API 26, enable core-library desugaring in the **app** module:

```groovy
android {
    compileOptions {
        coreLibraryDesugaringEnabled true
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
}
dependencies {
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.1.5'
}
```

### Android tooling

The plugin uses `kotlin.compilerOptions` and lets Flutter provide Kotlin integration.
Flutter 3.44 supports the legacy Kotlin setup; Flutter 3.47 / AGP 9 supports built-in Kotlin.
Enable `android.builtInKotlin=true` only after all app plugins support it, and retain Flutter's `android.newDsl=false` setting.
See the example for configuration. Validate a minified release build with your vendor credentials and measurement identifiers.

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
