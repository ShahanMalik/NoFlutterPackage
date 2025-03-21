import 'package:flutter/material.dart';

import 'cupertino_style_loader.dart';

class CupertinoStyleLoaderMain extends StatefulWidget {
  const CupertinoStyleLoaderMain({super.key});

  @override
  State<CupertinoStyleLoaderMain> createState() => _CupertinoStyleLoaderMainState();
}

class _CupertinoStyleLoaderMainState extends State<CupertinoStyleLoaderMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CupertinoStyleLoader(
          color: Colors.white,
          size: 60.0,
          duration: const Duration(milliseconds: 800),
        ),
      ),
    );
  }
}