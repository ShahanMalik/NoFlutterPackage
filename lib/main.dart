import 'package:flutter/material.dart';
import 'package:flutter_tutorials/LoadingIndicator/DualPulseLoader/example1/dual_pulseLoading_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DualPulseLoadingMain(),
    );
  }
}
