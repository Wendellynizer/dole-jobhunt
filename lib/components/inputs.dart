import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.hintText,
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      // material design for box shadow
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,


      child: TextField(
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
    required this.hintText
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      // material design for box shadow
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,

      child: TextField(
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
    required this.options
  });

  final String hintText;
  final List<DropdownMenuEntry<dynamic>> options;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: light,
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,

      child: DropdownMenu(
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
    required this.maxLines
  });

  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Material(
      // material design for box shadow
      shadowColor: dark50,
      elevation: 1,
      borderRadius: borderSM,

      child: TextField(
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

