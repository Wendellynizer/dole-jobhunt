import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Icon icon;
  final Widget content;
  final double? width;
  
  const IconText({super.key, required this.icon, required this.content, this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: (width == null)? 14 : width,),
        content
      ],
    );
  }
}
