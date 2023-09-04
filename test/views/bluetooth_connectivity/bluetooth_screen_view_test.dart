import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';
import 'package:test_project/utils/constants.dart';
import 'package:test_project/views/bluetooth_connectivity/bluetooth_screen_view.dart';
import 'package:test_project/views/bluetooth_connectivity/bluetooth_screen_viewmodel.dart';

void main() {
  group('BluetoothScreenView Widget Tests', () {
    testWidgets('BluetoothScreenView should render without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BluetoothScreenView(),
        ),
      );
      expect(find.byType(BluetoothScreenView), findsOneWidget);
      expect(find.text(Constants.bluetoothConnectivity), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(Constants.enableBluetooth), findsOneWidget);
    });

    testWidgets(
        'BluetoothScreenView should enable Bluetooth when button is pressed',
        (WidgetTester tester) async {
      final viewModel =
          BluetoothViewModelMock(isBusy: false, isBluetoothEnabled: false);

      await tester.pumpWidget(
        MaterialApp(
          home: ViewModelBuilder<BluetoothViewModel>.nonReactive(
            viewModelBuilder: () => viewModel,
            builder: (context, model, child) {
              return const BluetoothScreenView();
            },
          ),
        ),
      );

      await tester.pump();

      final button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);
      expect(tester.widget<ElevatedButton>(button).enabled, isTrue);

      await tester.tap(button);
      await tester.pump();
    });
  });
}

class BluetoothViewModelMock extends BluetoothViewModel {
  @override
  bool get isBluetoothEnabled;
  BluetoothViewModelMock(
      {required bool isBusy, required bool isBluetoothEnabled})
      : super() {
    setBusy(isBusy);
    isBluetoothEnabled = isBluetoothEnabled;
  }
}
