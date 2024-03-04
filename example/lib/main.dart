import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_android_info/flutter_android_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String versionRelease = '';
  String brand = '';
  String model = '';
  String device = '';
  String buildId = '';
  String androidId = '';
  String deviceId = '';
  String apkMd5 = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> getAndroidInfo() async {
    versionRelease = await FlutterAndroidInfo.versionRelease() ?? '';
    brand = await FlutterAndroidInfo.brand() ?? '';
    model = await FlutterAndroidInfo.model() ?? '';
    device = await FlutterAndroidInfo.device() ?? '';
    buildId = await FlutterAndroidInfo.buildId() ?? '';
    androidId = await FlutterAndroidInfo.androidId() ?? '';
    deviceId = await FlutterAndroidInfo.deviceId() ?? '';
    apkMd5 = await FlutterAndroidInfo.apkMd5() ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_android_info example app'),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Version Release: $versionRelease'),
            Text('Brand: $brand'),
            Text('Model: $model'),
            Text('Device: $device'),
            Text('Build ID: $buildId'),
            Text('Android ID: $androidId'),
            Text('Device ID: $deviceId'),
            Text('Apk Md5: $apkMd5'),
            TextButton(
                onPressed: getAndroidInfo,
                child: const Text('Get Android Info'))
          ],
        )),
      ),
    );
  }
}
