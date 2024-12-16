import 'package:flutter/material.dart';

// colors
Color primaryColor = const Color(0xffE8F1FE);
Color secondaryColor = const Color(0xff133E87);
Color accentColor = const Color(0xffBCD3FF);
Color light = Colors.white;
Color light50 = const Color(0x99ffffff);
Color dark = const Color(0xee000000);
Color dark50 = const Color(0x99000000);
Color red = const Color(0xffF47272);
Color hintColor = Color(0x000000).withOpacity(0.3);

// texts
// text sizes
double text_xs = 12.0;
double text_sm = 14.0;
double text_md = 16.0;
double text_lg = 20.0;
double text_xl = 24.0;

double text_h6 = 24.0;
double text_h5 = 26.0;
double text_h4 = 30.0;

double text_h1 = 32.0;
double text_h2 = 28.0;
double text_h3 = 26.0;

// font weights
FontWeight bold = FontWeight.bold;
FontWeight semibold = FontWeight.w600;
FontWeight medium = FontWeight.w500;

// input in style: in TextStyle
TextStyle headerStyle = TextStyle(
    color: dark,
    fontSize: 28,
    fontWeight: FontWeight.bold
);

// padding
EdgeInsets horizontal = const EdgeInsets.symmetric(horizontal: 26);
EdgeInsets cardPadding = const EdgeInsets.symmetric(horizontal: 18, vertical: 10);
EdgeInsets buttonPadding  = const EdgeInsets.symmetric(vertical: 16, horizontal: 16);

// border radius
BorderRadius borderSM = const BorderRadius.all(Radius.circular(5));
BorderRadius border = const BorderRadius.all(Radius.circular(10));
BorderRadius borderM = const BorderRadius.all(Radius.circular(20));
BorderRadius borderL = const BorderRadius.all(Radius.circular(50));
