import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class snapLoader extends StatefulWidget {
  const snapLoader({super.key});

  @override
  State<snapLoader> createState() => _snapLoaderState();
}

class _snapLoaderState extends State<snapLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1450),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showLoader() {
    _controller.repeat();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: CustomCircularLoader(
            size: 60,
            color: Color.fromARGB(255, 0, 0, 0),
            strokeWidth: 3.5,
            controller: _controller,
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 4), () {
      _controller.stop();
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _hideLoader() {
    _controller.stop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: _showLoader,
              style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 7, 118, 140),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 5,
              ),
              child: Text(
              'Show Loader',
              style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class CustomCircularLoader extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;
  final AnimationController controller;

  CustomCircularLoader({
    required this.size,
    required this.color,
    required this.strokeWidth,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _CircularLoaderPainter(
                    rotation: controller.value,
                    color: color,
                    strokeWidth: strokeWidth,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: size * 0.59,
            height: size * 0.59,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _CircularLoaderPainter(
                    rotation: 1 - controller.value,
                    color: color,
                    strokeWidth: strokeWidth,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularLoaderPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final double strokeWidth;

  _CircularLoaderPainter({
    required this.rotation,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double startAngle = 2 * pi * rotation;
    const double sweepAngle = 1 * pi;

    final Gradient gradient = SweepGradient(
      colors: [
        color.withOpacity(1.0),
        color.withOpacity(1.0),
        color.withOpacity(0.0),
      ],
      stops: [0.2, 0.1, 1.0],
      transform: GradientRotation(startAngle),
    );

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.shader = gradient.createShader(rect);

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
