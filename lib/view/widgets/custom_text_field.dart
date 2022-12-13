import 'package:flutter/material.dart';

import '../animations/animations.dart';

class StaggerTextFormField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final String hintText;
  final String labelText;
  final int? maxLines;
  final String? initialValue;
  final bool obscureText;
  final double startAnimation;
  final double endAnimation;
  final Key? inputKey;

  const StaggerTextFormField({
    Key? key,
    this.inputKey,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.focusNode,
    this.controller,
    this.maxLines = 1,
    this.obscureText = false,
    this.onEditingComplete,
    this.initialValue,
    required this.hintText,
    required this.labelText,
    required this.startAnimation,
    required this.endAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggerAnimationComponent(
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      component: TextFormField(
        key: inputKey,
        initialValue: initialValue,
        controller: controller,
        focusNode: focusNode,
        maxLines: maxLines,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
            suffixIcon: suffixIcon, hintText: hintText, label: Text(labelText)),
      ),
    );
  }
}
