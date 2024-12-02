import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.hintText,
    this.autoFocus,
    this.controller
  });

  final String hintText;
  final bool? autoFocus;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      // material design for box shadow
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,


      child: TextField(
        controller: controller,
        autofocus: (autoFocus == null)? false : autoFocus!,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),


            filled: true,
            fillColor: light,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
            ),
        ),
      ),
    );
  }
}

// for number inputs
class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
    required this.hintText,
    this.controller
  });

  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      // material design for box shadow
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,

      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),


          filled: true,
          fillColor: light,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

// dropdown
class DropdownInput extends StatelessWidget {
  const DropdownInput({
    super.key,
    required this.hintText,
    required this.options,
    required this.onSelected
  });

  final String hintText;
  final List<DropdownMenuEntry<dynamic>> options;
  final ValueChanged<dynamic> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: light,
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,

      child: DropdownMenu(
        onSelected: onSelected,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(light),
        ),

        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),

        hintText: hintText,

        dropdownMenuEntries: options,
      ),
    );
  }
}

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    required this.hintText,
    required this.maxLines,
    this.controller
  });

  final String hintText;
  final int maxLines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      // material design for box shadow
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,

      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),


          filled: true,
          fillColor: light,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

