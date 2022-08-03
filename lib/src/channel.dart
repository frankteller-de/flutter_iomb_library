import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'interface.dart';

class IombLibraryHelpers {
  /// Cast dart enum into string
  static String enumToString<T extends Enum>(T value) {
    return value.toString().split('.').last;
  }
}

/// An implementation of [IombLibrary] that uses method channels.
class MethodChannelFlutterIombLibrary extends IombLibrary {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_iomb_library');

  @override
  final PlatformIOS ios = PlatformIOS();
  @override
  final PlatformAndroid android = PlatformAndroid();

  @override
  Future<void> sessionConfiguration({required String baseURL, required String offerIdentifier, String? hybridIdentifier}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('baseURL', () => baseURL);
    args.putIfAbsent('offerIdentifier', () => offerIdentifier);
    args.putIfAbsent('hybridIdentifier', () => hybridIdentifier);
    await methodChannel.invokeMethod<void>('sessionConfiguration', args);
  }

  @override
  Future<void> logViewEvent({required IOMBViewEvent type, required String category, String? comment}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('type', () => type.toString().split('.').last);
    args.putIfAbsent('category', () => category);
    args.putIfAbsent('comment', () => comment);
    await methodChannel.invokeMethod<void>('logViewEvent', args);
  }

  /// Nur bei Opt-out durch den Nutzer verwenden!
  @override
  Future<void> terminateSession() async {
    await methodChannel.invokeMethod<void>('terminateSession');
  }
}

class PlatformIOS extends IombLibraryPlatformIOS {
  final methodChannel = const MethodChannel('flutter_iomb_library');

  @override
  Future<void> setDebugLogLevel(IOMBDebugLevel level) async {
    if (!Platform.isIOS) return;
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('level', () => IombLibraryHelpers.enumToString(level));
    await methodChannel.invokeMethod<void>('setDebugLogLevel', args);
  }
}

class PlatformAndroid extends IombLibraryPlatformAndroid {
  final methodChannel = const MethodChannel('flutter_iomb_library');

  @override
  Future<void> setDebugModeEnabled(bool enable) async {
    if (!Platform.isAndroid) return;
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('enable', () => enable);
    await methodChannel.invokeMethod<void>('setDebugModeEnabled', args);
  }
}