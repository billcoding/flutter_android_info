import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flutter_android_info_platform_interface.dart';

/// An implementation of [FlutterAndroidInfoPlatform] that uses method channels.
class MethodChannelFlutterAndroidInfo extends FlutterAndroidInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_android_info');

  Future<String?> invoke(String method) async =>
      methodChannel.invokeMethod<String>(method);

  @override
  Future<String?> versionRelease() async => invoke("versionRelease");

  @override
  Future<String?> brand() async => invoke("brand");

  @override
  Future<String?> model() async => invoke("model");

  @override
  Future<String?> device() async => invoke("device");

  @override
  Future<String?> buildId() async => invoke("buildId");

  @override
  Future<String?> androidId() async => invoke("androidId");

  @override
  Future<String?> deviceId() async => invoke("deviceId");

  @override
  Future<String?> apkMd5() async => invoke("apkMd5");
}
