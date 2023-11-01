import 'package:flutter/material.dart';

const mainColor = Color(0xff2d4569);
const secondColor = Color(0xff819f7f);
const thirdColor = Color(0xfffdfbda);
const fourthColor = Color(0xffd3d0a8);
Color lightScaffoldColor = const Color(0xFFF3F4F8);
Color lightCardColor = const Color(0xFFFFFFFF); //F0FFFF
Color lightBackgroundColor = const Color(0xFFD0E8F2);
Color lightIconsColor = const Color(0xFF79A3B1);
Color lightMainTextColor = const Color(0xFF56485d);
Color lightSubTextColor = const Color(0xFF000000);
Color lightTextColor = const Color(0xFF000000);

//* Dark theme
Color darkScaffoldColor = const Color(0xFF121B22);
Color darkCardColor = const Color(0xFF1F2C34);
Color darkBackgroundColor = const Color(0xFF0F3460);
Color darkIconsColor = const Color(0xFF00A783);
Color darkMainTextColor = const Color(0xFFFFFFFF);
Color darkSubTextColor = const Color.fromARGB(255, 40, 104, 57);
Color darkTextColor = const Color(0xFFFFFFFF);

//* common colors
Color versionTextColor = const Color(0xFFE94560);
Color linkColor = const Color(0xFF64B5F6);

class CustomTheme {
  static const buttonShadow = [
    BoxShadow(
        color: Colors.grey,
        blurRadius: 3,
        spreadRadius: 2,
        offset: Offset(1, 1))
  ];
  static const cardShadow = [
    BoxShadow(
        color: Colors.grey,
        blurRadius: 6,
        spreadRadius: 4,
        offset: Offset(0, 2))
  ];

  static getCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      boxShadow: cardShadow,
    );
  }
}
