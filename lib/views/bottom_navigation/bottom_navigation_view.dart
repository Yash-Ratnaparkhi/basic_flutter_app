import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_project/views/bottom_navigation/bottom_navigation_viewmodel.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavigationViewModel>.reactive(
      viewModelBuilder: () => BottomNavigationViewModel(),
      builder: (context, model, child) => Scaffold(
        body: model.tabs[model.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.currentIndex,
          onTap: (int index) => model.handleIndexChange(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.pets_outlined),
              label: 'Images',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth),
              label: 'Bluetooth',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
