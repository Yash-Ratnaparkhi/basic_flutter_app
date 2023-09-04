import 'package:flutter/material.dart';
import 'views/bottom_navigation/bottom_navigation_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigationView(),
    );
  }
}
