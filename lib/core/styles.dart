import 'package:flutter/material.dart';
import 'ui_helper.dart';

class Styles {
  static const labelTxtStyle = TextStyle(
      fontFamily: 'edo',
      fontWeight: FontWeight.w600,
      color: darkbrown,
      fontSize: 35,
      shadows: [
        Shadow(offset: Offset(-1.5, -1.5), color: Colors.white),
        Shadow(offset: Offset(1.5, -1.5), color: Colors.white),
        Shadow(offset: Offset(1.5, 1.5), color: Colors.white),
        Shadow(offset: Offset(-1.5, 1.5), color: Colors.white),
      ]);

  static const sLabelTxtStyle = TextStyle(
      fontFamily: 'edo',
      fontWeight: FontWeight.w600,
      color: darkbrown,
      fontSize: 20,
      shadows: [
        Shadow(offset: Offset(-1.5, -1.5), color: Colors.white),
        Shadow(offset: Offset(1.5, -1.5), color: Colors.white),
        Shadow(offset: Offset(1.5, 1.5), color: Colors.white),
        Shadow(offset: Offset(-1.5, 1.5), color: Colors.white),
      ]);

  static const titleBarStyle = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w800,
      color: black,
      fontSize: 20);

  static const wBold14 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 14);

  static const wBold12 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 12);

  static const bRegular16 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w500,
      color: black,
      fontSize: 16);

  static const bBold15 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontSize: 15);

  static const bBold12 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontSize: 12);

  static const bRegular12 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      color: black,
      fontSize: 12);

  static const boxCardShdStyle = BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 7,
      spreadRadius: 1,
      color: Colors.black12);

  static const snackBarRemBookmark = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.remove_circle_rounded, color: Colors.white),
    ]),
    backgroundColor: darkblue,
    behavior: SnackBarBehavior.floating,
  );
}
