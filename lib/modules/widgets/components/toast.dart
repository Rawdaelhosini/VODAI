import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void defaultToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Color(0xFFECF0ED),
        fontSize: 16.0);

// ignore: constant_identifier_names
enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color? color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.redAccent;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
