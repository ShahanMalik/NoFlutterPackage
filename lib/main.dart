import 'package:flutter/material.dart';
import 'LoadingIndicator/snapLoader/snap_loader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: snapLoader(),
      // home: Scaffold(),
    );
  }
}
