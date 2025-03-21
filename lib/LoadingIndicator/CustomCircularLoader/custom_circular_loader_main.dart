import 'package:flutter/material.dart';
import 'package:flutter_tutorials/LoadingIndicator/CustomCircularLoader/custom_circular_loader.dart';

class CustomCircularLoaderMain extends StatefulWidget {
  @override
  State<CustomCircularLoaderMain> createState() =>
      _CustomCircularLoaderMainState();
}

class _CustomCircularLoaderMainState extends State<CustomCircularLoaderMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter Circular Progress Indicator",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )),
            SizedBox(height: 50.0),
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(height: 50.0),
            Text("My Circular Progress Indicator",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )),
            SizedBox(height: 50.0),
            CustomCircularLoader(
              size: 45.0,
              color: Colors.white,
              strokeWidth: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
