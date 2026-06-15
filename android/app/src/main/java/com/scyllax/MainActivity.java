package com.hashmicro;
import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.telephony.TelephonyManager;
import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterFragmentActivity {
    private static final String CHANNEL = "com.hashmicro/imei";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getImei")) {
                                String imei = getImei();
                                result.success(imei);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private String getImei() {
        Context context = this.getApplicationContext();
        TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                return telephonyManager.getImei();
            } else {
                return telephonyManager.getDeviceId();
            }
        } else {
            return "Permission denied";
        }
    }
}
