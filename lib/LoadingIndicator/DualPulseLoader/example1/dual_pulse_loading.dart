import 'package:flutter/material.dart';
import 'package:flutter_tutorials/LoadingIndicator/DualPulseLoader/example1/ball_position.dart';

class DualPulseLoading extends StatefulWidget {
  const DualPulseLoading({super.key});

  @override
  State<DualPulseLoading> createState() => _DualPulseLoadingState();
}

class _DualPulseLoadingState extends State<DualPulseLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 630),
      vsync: this,
    )..repeat(reverse: true);

    /// [ 0 - 59 should be the range of the animation (balls) ]
    _animation = Tween<double>(begin: 0, end: 59).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 55,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              (_animation.status == AnimationStatus.reverse)
                  ? BallPosition(
                      animation: _animation, color: Colors.blue, isLeft: true)
                  : BallPosition(
                      animation: _animation, color: Colors.red, isLeft: false),

              /////////////////////////

              (_animation.status == AnimationStatus.forward)
                  ? BallPosition(
                      animation: _animation, color: Colors.blue, isLeft: true)
                  : BallPosition(
                      animation: _animation, color: Colors.red, isLeft: false),
            ],
          );
        },
      ),
    );
  }
}
