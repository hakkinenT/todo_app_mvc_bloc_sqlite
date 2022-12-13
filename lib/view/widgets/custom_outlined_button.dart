import 'package:flutter/material.dart';

import '../animations/animations.dart';

class StaggerOutlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final double startAnimation;
  final double endAnimation;

  const StaggerOutlinedButton(
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
          child: OutlinedButton(onPressed: onPressed, child: child)),
    );
  }
}
