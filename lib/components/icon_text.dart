import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Icon icon;
  final Widget content;
  final double? width;
  final double? bottomMargin;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const IconText({
    super.key,
    required this.icon,
    required this.content,
    this.width,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.bottomMargin
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (mainAxisAlignment == null)? MainAxisAlignment.start : mainAxisAlignment!,
      crossAxisAlignment: (crossAxisAlignment == null)? CrossAxisAlignment.start : crossAxisAlignment!,
      children: [
        icon,
        SizedBox(width: (width == null)? 14 : width,),
        content,

        SizedBox(height: (bottomMargin == null)? 0 : bottomMargin,)
      ],
    );
  }
}
