import 'package:dole_jobhunt/components/icon_text.dart';
import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final Icon icon;
  final String title;
  final Color? bgColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const Label({
    super.key,
    required this.icon,
    required this.title,
    this.bgColor,
    this.textStyle,
    this.borderRadius,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (padding == null)
      ? const EdgeInsets.symmetric(vertical: 4, horizontal: 6)
      : padding,

      decoration: BoxDecoration(
        color: (bgColor == null)? Color(0x000000).withOpacity(0.5) : bgColor,
        borderRadius: (borderRadius == null)? borderSM : borderRadius
      ),

      child: IconText(
          crossAxisAlignment: CrossAxisAlignment.center,
          icon: icon,
          content: Text(
            title,
            style: (textStyle == null)? TextStyle(color: light) : textStyle,
          ),
          width: 6,
      ),
    );
  }
}
