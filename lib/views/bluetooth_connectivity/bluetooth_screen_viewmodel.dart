import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class BluetoothViewModel extends BaseViewModel {
  static const platform = MethodChannel('bluetooth_channel');
  bool _isBluetoothEnabled = false;
  bool get isBluetoothEnabled => _isBluetoothEnabled;
  Future<void> enableBluetooth(context) async {
    setBusy(true);
    bool permOne = await Permission.bluetoothScan.request().isGranted;
    bool permTwo = await Permission.bluetoothAdvertise.request().isGranted;
    bool permThree = await Permission.bluetoothConnect.request().isGranted;
    if (permOne && permTwo && permThree) {
      try {
        final bool enableResult =
            await platform.invokeMethod('enableBluetooth');
        if (enableResult) {
          _showSnackBar(context, 'Bluetooth is enabled');
          _isBluetoothEnabled = true;
          notifyListeners();
        } else {
          _isBluetoothEnabled = false;
          notifyListeners();
          _showSnackBar(context, 'Bluetooth is already enabled');
        }
      } catch (e) {
        _showSnackBar(context, 'Error enabling Bluetooth: $e');
      }
    } else {
      _showSnackBar(context, 'Permission denied: BLUETOOTH_CONNECT');
    }
    setBusy(false);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
