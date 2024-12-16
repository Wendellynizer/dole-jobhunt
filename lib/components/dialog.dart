import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';


class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    required this.title,
    this.content,
    this.actions
  });

  final Widget title;
  final Widget? content;
  final List<Widget>? actions;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: (widget.content == null)? const SizedBox.shrink() : widget.content,
      actions: widget.actions,


      shape: RoundedRectangleBorder(
        borderRadius: border
      ),
    );
  }
}
