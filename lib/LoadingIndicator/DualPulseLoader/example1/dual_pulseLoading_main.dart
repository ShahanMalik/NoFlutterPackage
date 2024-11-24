import 'package:flutter/material.dart';
import 'package:flutter_tutorials/LoadingIndicator/DualPulseLoader/example1/dual_pulse_loading.dart';

class DualPulseLoadingMain extends StatefulWidget {
  const DualPulseLoadingMain({super.key});

  @override
  State<DualPulseLoadingMain> createState() => _DualPulseLoadingMainState();
}

class _DualPulseLoadingMainState extends State<DualPulseLoadingMain> {
  int displayDataIndex = 0;
  List<String> data = [
    '👍 Like this post to show your support!',
    '👥 Follow me for more amazing content!',
    '🌟 Star my GitHub repo to encourage me!',
  ];
  void _showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: SizedBox(
              width: 110,
              height: 55,
              child: DualPulseLoading(),
            ),
          ),
        );
      },
    );
    fetchData();
  }

  Future<void> fetchData() async {
    /// [ You can replace the below code with your data loading code ]
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
        setState(() {
          displayDataIndex++;
          if (displayDataIndex >= data.length) {
            displayDataIndex = 0;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dual Pulse Loading Example'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
              child: Text(
                data[displayDataIndex],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            )),
            ElevatedButton(
              onPressed: _showLoader,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 54, vertical: 14),
                textStyle: TextStyle(fontSize: 17),
              ),
              child: Text('Show Loading'),
            ),
          ],
        ),
      ),
    );
  }
}
