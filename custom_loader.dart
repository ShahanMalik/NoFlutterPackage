import 'package:flutter/material.dart';
import 'dart:math' as math show sin, pi;

class CustomLoader extends StatefulWidget {
  const CustomLoader({
    Key? key,
    this.Loadercolor = Colors.white, // Default color to white
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
    required this.myLoaderController,
    this.text,
    this.textStyle,
    this.containerWidth, // renamed width to containerWidth
    this.containerHeight, // renamed height to containerHeight
  })  : assert(
          !(itemBuilder is IndexedWidgetBuilder && Loadercolor is Color) &&
              !(itemBuilder == null && Loadercolor == null),
          'You should specify either an itemBuilder or a color',
        ),
        super(key: key);

  final Color Loadercolor;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;
  final MyLoaderController myLoaderController;
  final String? text;
  final TextStyle? textStyle;
  final double? containerWidth; // renamed width to containerWidth
  final double? containerHeight; // renamed height to containerHeight

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  static const _itemCount = 12;

  late AnimationController _controller;
  bool _isVisible = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();

    widget.myLoaderController.setDismiss(dismiss);
  }

  @override
  void dispose() {
    _isDisposed = true;
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void dismiss() {
    if (!_isDisposed) {
      if (widget.controller == null) {
        _controller.stop();
      }
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.containerWidth ?? 25,
                vertical: widget.containerHeight ?? 20,
              ),
              decoration: BoxDecoration(
                color: Colors.black, // Black background
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox.fromSize(
                    size: Size.square(widget.size),
                    child: Stack(
                      children: List.generate(_itemCount, (index) {
                        final position = widget.size * .5;
                        return Positioned.fill(
                          left: position,
                          top: position,
                          child: Transform(
                            transform:
                                Matrix4.rotationZ(30.0 * index * 0.0174533),
                            child: Align(
                              alignment: Alignment.center,
                              child: ScaleTransition(
                                scale: DelayTween(
                                  begin: 0.0,
                                  end: 1.0,
                                  delay: index / _itemCount,
                                ).animate(_controller),
                                child: SizedBox.fromSize(
                                  size: Size.square(widget.size * 0.15),
                                  child: _itemBuilder(index),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  if (widget.text != null)
                    SizedBox(height: 10), // Space below the loader
                  if (widget.text != null)
                    Text(
                      widget.text!,
                      style: widget.textStyle ??
                          TextStyle(fontSize: 16, color: Colors.white),
                    ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration: BoxDecoration(
            color: widget.Loadercolor,
            shape: BoxShape.circle,
          ),
        );
}

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

class MyLoaderController {
  VoidCallback? _dismiss;

  void setDismiss(VoidCallback dismiss) {
    _dismiss = dismiss;
  }

  void dismiss() {
    _dismiss?.call();
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {


  /// [ add this line]
  final MyLoaderController _loaderController = MyLoaderController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLoader(
            containerWidth: 32,
            containerHeight: 34,
            size: 60,
            myLoaderController: _loaderController,
            Loadercolor: Color.fromARGB(255, 255, 236, 236),
            text: 'Loading...',
            textStyle: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _loaderController.dismiss();
              },
              child: Text('Dismiss Loader'))
        ],
      ),
    );
  }
}
