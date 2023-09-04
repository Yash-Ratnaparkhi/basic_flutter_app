import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_project/views/Pets/pet_screen_view.dart';
import 'package:test_project/views/bluetooth_connectivity/bluetooth_screen_view.dart';
import 'package:test_project/views/profile/profile_screen_view.dart';

class BottomNavigationViewModel extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void handleIndexChange(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<Widget> tabs = [
    const PetScreen(),
    const BluetoothScreenView(),
    const ProfilePage(),
  ];
}
