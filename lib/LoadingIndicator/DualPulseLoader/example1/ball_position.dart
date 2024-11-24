import 'package:flutter/material.dart';

class BallPosition extends StatelessWidget {
  final Color color;
  final bool isLeft;

  const BallPosition({
    super.key,
    required Animation<double> animation,
    required this.color,
    required this.isLeft,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isLeft ? _animation.value : null,
      right: isLeft ? null : _animation.value,
      top: 1,
      child: Container(
        width: 49,
        height: 49,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
