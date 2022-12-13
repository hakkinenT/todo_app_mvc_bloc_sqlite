import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute(
      {required this.page, required super.settings, super.fullscreenDialog})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration: const Duration(milliseconds: 900),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(-1.0, 0.0), end: Offset.zero)
                      .animate(animation),
                  child: child,
                ));
}
