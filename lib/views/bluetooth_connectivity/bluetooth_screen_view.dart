import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_project/utils/constants.dart';
import 'bluetooth_screen_viewmodel.dart';

class BluetoothScreenView extends StatelessWidget {
  const BluetoothScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BluetoothViewModel>.reactive(
      viewModelBuilder: () => BluetoothViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text(Constants.bluetoothConnectivity)),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: model.isBluetoothEnabled
                      ? null
                      : () {
                          model.enableBluetooth(context);
                        },
                  child: const Text(Constants.enableBluetooth),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
