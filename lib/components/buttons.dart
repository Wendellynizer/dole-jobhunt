import 'package:flutter/material.dart';

import '../globals/style.dart';

class Button extends StatelessWidget {

  final Widget content;
  final Color color;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;


  const Button({
    super.key,
    required this.content,
    required this.color,
    required this.onPressed,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: (borderRadius == null)? border : borderRadius!),
      padding: buttonPadding,

      elevation: 0,
      child: content,
    );
  }
}
