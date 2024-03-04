package com.rwscode.plugins.android_info;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.io.FileInputStream;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
/**
 * FlutterAndroidInfo
 */
public class FlutterAndroidInfo implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    private static final String versionRelease = Build.VERSION.RELEASE;
    private static final String brand = Build.BRAND;
    private static final String model = Build.MODEL;
    private static final String device = Build.DEVICE;
    private static String buildId = getBuildId("_");
    private static String androidId = "";
    private static String deviceId = "";
    private static String apkMd5 = "";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_android_info");
        channel.setMethodCallHandler(this);
        final Context ctx = flutterPluginBinding.getApplicationContext();
        androidId = Settings.Secure.getString(ctx.getContentResolver(), Settings.Secure.ANDROID_ID);
        apkMd5 = getApkMd5(ctx);
        deviceId = getDeviceId();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        // Android 13
        switch (call.method){
            default: 
                result.notImplemented();
                break;
            case "versionRelease":
                result.success(versionRelease);
                break;
            case "brand":
                result.success(brand);
                break;
            case "model":
                result.success(model);
                break;
            case "device":
                result.success(device);
                break;
            case "buildId":
                result.success(buildId);
                break;
            case "androidId":
                result.success(androidId);
                break;
            case "deviceId":
                result.success(deviceId);
                break;
            case "apkMd5":
                result.success(apkMd5);
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private static String getDeviceId() {
        return Base64.getEncoder().encodeToString((deviceId + buildId).getBytes());
    }

    private static String getBuildId(String delimiter) {
        List<String> list = new ArrayList<>();
        list.add(brand);
        list.add(model);
        list.add(device);
        if (Build.VERSION.SDK_INT >= 31) {
            list.add(Build.SOC_MANUFACTURER);
            list.add(Build.SOC_MODEL);
        }
        return String.join(delimiter, list);
    }

    public static String getApkMd5(Context ctx) {
        String packageName = ctx.getPackageName();
        String apkMd5 = "";
        try {
            // 获取应用程序的 ApplicationInfo 实例
            ApplicationInfo applicationInfo = ctx.getPackageManager().getApplicationInfo(packageName, 0);

            // 获取应用程序的根目录
            String apkPath = applicationInfo.sourceDir;
            Log.d("getApkMd5", "apkPath：" + apkPath);

            // 创建一个文件输入流对象
            FileInputStream fis = new FileInputStream(apkPath);
            // 创建一个 MessageDigest 实例
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                md.update(buffer, 0, bytesRead);
            }
            apkMd5 = byteArrayToHexString(md.digest()).toLowerCase();
        } catch (Exception ex) {
            Log.d("getApkMd5", "error：" + ex.getMessage());
        }
        Log.d("getApkMd5", "current apk md5：" + apkMd5);
        return apkMd5;
    }

    private static final char[] hexArray = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

    private static String byteArrayToHexString(byte[] bytes) {
        char[] hexChars = new char[bytes.length*2];
        int v;
        for(int j=0; j < bytes.length; j++) {
            v = bytes[j] & 0xFF;
            hexChars[j*2] = hexArray[v>>>4];
            hexChars[j*2 + 1] = hexArray[v & 0x0F];
        }
        return new String(hexChars);
    }
}
