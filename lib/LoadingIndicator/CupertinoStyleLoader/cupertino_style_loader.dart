import 'dart:math' as math;
import 'package:flutter/material.dart';


/// A widget that displays a fading circle animation.
class CupertinoStyleLoader extends StatefulWidget {
  const CupertinoStyleLoader({
    Key? key,
    this.color,
    this.size = 70.0,
    this.duration = const Duration(milliseconds: 900),
    this.controller,
  }) : super(key: key);

  final Color? color;
  final double size;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<CupertinoStyleLoader> createState() => _CupertinoStyleLoaderState();
}

class _CupertinoStyleLoaderState extends State<CupertinoStyleLoader>
    with SingleTickerProviderStateMixin {
  static const int itemCount = 12;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(itemCount, (index) {
            final double position = widget.size * 0.5;
            return Positioned.fill(
              left: position,
              top: position,
              child: Transform(
                transform: Matrix4.rotationZ(30.0 * index * 0.0174533),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FadeTransition(
                    opacity: DelayTween(
                      begin: 0.0,
                      end: 1.0,
                      delay: index / itemCount,
                    ).animate(_controller),
                    child: SizedBox(
                      width: widget.size * 0.15,
                      height: widget.size * 0.05, // Height is double the width
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// A custom tween that introduces a delay in the animation.
class DelayTween extends Tween<double> {
  DelayTween({
    double? begin,
    double? end,
    required this.delay,
  }) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
