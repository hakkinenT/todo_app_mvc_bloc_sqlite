import 'package:flutter/material.dart';

import '../animations/animations.dart';

class StaggerTextButton extends StatelessWidget {
  final double startAnimation;
  final double endAnimation;
  final String label;
  final Function()? onPressed;

  const StaggerTextButton({
    Key? key,
    required this.startAnimation,
    required this.endAnimation,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggerAnimationComponent(
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      component: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
          )),
    );
  }
}
