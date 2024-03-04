import 'flutter_android_info_platform_interface.dart';

abstract class FlutterAndroidInfo {
  static Future<String?> versionRelease() {
    return FlutterAndroidInfoPlatform.instance.versionRelease();
  }

  static Future<String?> brand() {
    return FlutterAndroidInfoPlatform.instance.brand();
  }

  static Future<String?> model() {
    return FlutterAndroidInfoPlatform.instance.model();
  }

  static Future<String?> device() {
    return FlutterAndroidInfoPlatform.instance.device();
  }

  static Future<String?> buildId() {
    return FlutterAndroidInfoPlatform.instance.buildId();
  }

  static Future<String?> androidId() {
    return FlutterAndroidInfoPlatform.instance.androidId();
  }

  static Future<String?> deviceId() {
    return FlutterAndroidInfoPlatform.instance.deviceId();
  }

  static Future<String?> apkMd5() {
    return FlutterAndroidInfoPlatform.instance.apkMd5();
  }
}
