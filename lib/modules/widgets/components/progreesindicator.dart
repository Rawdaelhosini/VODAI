import 'package:flutter/material.dart';

Widget defaultCircularProgressIndicator() => const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF156B51),
      ),
    );

Widget defaultLinearProgressIndicator() => const Center(
      child: LinearProgressIndicator(
        minHeight: 5,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF156B51)),
        backgroundColor: Colors.white,
      ),
    );
