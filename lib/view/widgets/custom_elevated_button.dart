import 'package:flutter/material.dart';

import '../animations/animations.dart';

class StaggerElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final double startAnimation;
  final double endAnimation;

  const StaggerElevatedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.startAnimation,
      required this.endAnimation});

  @override
  Widget build(BuildContext context) {
    return StaggerAnimationComponent(
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      component: SizedBox(
        width: double.maxFinite,
        height: 52,
        child: ElevatedButton(onPressed: onPressed, child: child),
      ),
    );
  }
}
