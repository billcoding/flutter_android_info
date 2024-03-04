import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_android_info_method_channel.dart';

abstract class FlutterAndroidInfoPlatform extends PlatformInterface {
  /// Constructs a FlutterAndroidInfoPlatform.
  FlutterAndroidInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAndroidInfoPlatform _instance =
      MethodChannelFlutterAndroidInfo();

  /// The default instance of [FlutterAndroidInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAndroidInfo].
  static FlutterAndroidInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAndroidInfoPlatform] when
  /// they register themselves.
  static set instance(FlutterAndroidInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Get android.os.Build.VERSION.RELEASE
  Future<String?> versionRelease() {
    throw UnimplementedError('versionRelease() has not been implemented.');
  }

  /// Get android.os.Build.Brand
  Future<String?> brand() {
    throw UnimplementedError('brand() has not been implemented.');
  }

  /// Get android.os.Build.MODEL
  Future<String?> model() {
    throw UnimplementedError('model() has not been implemented.');
  }

  /// Get android.os.Build.DEVICE
  Future<String?> device() {
    throw UnimplementedError('device() has not been implemented.');
  }

  /// Get custom build id
  Future<String?> buildId() {
    throw UnimplementedError('buildId() has not been implemented.');
  }

  /// Get ANDROID_ID
  Future<String?> androidId() {
    throw UnimplementedError('androidId() has not been implemented.');
  }

  /// Get custom device id
  Future<String?> deviceId() {
    throw UnimplementedError('deviceId() has not been implemented.');
  }

  /// Get the base.apk md5
  Future<String?> apkMd5() {
    throw UnimplementedError('apkMd5() has not been implemented.');
  }
}
