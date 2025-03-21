import 'package:flutter/material.dart';
import 'dart:math';

class CustomCircularLoader extends StatefulWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  CustomCircularLoader({
    required this.size,
    required this.color,
    this.strokeWidth = 4.0,
  });

  @override
  _CustomCircularLoaderState createState() => _CustomCircularLoaderState();
}

class _CustomCircularLoaderState extends State<CustomCircularLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _CircularLoaderPainter(
              rotation: _controller.value, // Pass rotation value
              color: widget.color,
              strokeWidth: widget.strokeWidth,
            ),
          );
        },
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

    final double startAngle = 2 * pi * rotation; // Dynamic start angle
    const double sweepAngle = 1.5 * pi;

    // Define gradient for the dynamic arc
    final Gradient gradient = SweepGradient(
      colors: [
        color.withOpacity(0.0),
        color.withOpacity(1.0),
        color.withOpacity(0.0),
      ],
      stops: [0.0, 0.7, 1.0],
      transform: GradientRotation(startAngle), // Rotate gradient with arc
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
    return true; // Continuously repaint for smooth animation
  }
}
