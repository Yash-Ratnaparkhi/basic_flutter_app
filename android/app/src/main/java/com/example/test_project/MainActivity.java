package com.example.test_project;

import android.bluetooth.BluetoothAdapter;
import android.content.Intent;
import android.os.Build;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "bluetooth_channel";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
        (call, result) -> {
          if (call.method.equals("enableBluetooth")) {
            enableBluetooth(result);
          } else {
            result.notImplemented();
          }
        });
  }

  private void enableBluetooth(MethodChannel.Result result) {
    BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();

    if (bluetoothAdapter == null) {
      result.error("BLUETOOTH_UNAVAILABLE", "Bluetooth is not available on this device", null);
      return;
    }

    if (!bluetoothAdapter.isEnabled()) {
      Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
      startActivity(enableBtIntent);
      result.success(true);
    } else {
      result.success(false);
    }
  }
}
