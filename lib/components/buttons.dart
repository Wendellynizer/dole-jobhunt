import 'package:flutter/material.dart';

import '../globals/style.dart';

class Button extends StatelessWidget {

  final Widget content;
  final Color color;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  final double? width;
  final EdgeInsets? padding;

  const Button({
    super.key,
    required this.content,
    required this.color,
    required this.onPressed,
    this.borderRadius,
    this.width,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: (borderRadius == null)? border : borderRadius!),
      padding: (padding == null)? buttonPadding : padding,
      minWidth: 5,


      elevation: 0,
      child: content,
    );
  }
}
