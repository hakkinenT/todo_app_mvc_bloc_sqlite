import 'package:flutter/material.dart';

class StaggerAnimationComponent extends StatefulWidget {
  /// Animation start time
  final double startAnimation;

  /// Animation end time
  final double endAnimation;

  /// Widget that will be animated
  final Widget component;

  const StaggerAnimationComponent(
      {super.key,
      required this.component,
      required this.startAnimation,
      required this.endAnimation});

  @override
  State<StaggerAnimationComponent> createState() =>
      _StaggerAnimationComponentState();
}

class _StaggerAnimationComponentState extends State<StaggerAnimationComponent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 750))
    ..forward();

  late final Animation<double> _animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(widget.startAnimation, widget.endAnimation,
              curve: Curves.easeIn)));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.component,
    );
  }
}
