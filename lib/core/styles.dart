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

  static const xsLabelTxtStyle = TextStyle(
      fontFamily: 'edo',
      fontWeight: FontWeight.w600,
      color: darkbrown,
      fontSize: 14,
      shadows: [
        Shadow(offset: Offset(-1.5, -1.5), color: Colors.white),
        Shadow(offset: Offset(1.5, -1.5), color: Colors.white),
        Shadow(offset: Offset(1.5, 1.5), color: Colors.white),
        Shadow(offset: Offset(-1.5, 1.5), color: Colors.white),
      ]);

  static const excellent = TextStyle(
      fontFamily: 'edo',
      fontWeight: FontWeight.w700,
      color: red,
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

  static const wBold13 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 13);

  static const wBold15 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 15);

  static const wBold10 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 10);

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
      fontWeight: FontWeight.bold,
      color: black,
      height: 1.5,
      fontSize: 12);

  static const boxCardShdStyle = BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 7,
      spreadRadius: 1,
      color: Colors.black12);

  static ButtonStyle basicBtn = ElevatedButton.styleFrom(
    elevation: 0.5,
    textStyle: wBold15,
    backgroundColor: darkblue,
    minimumSize: Size(120, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );
  static const snackBarRemBookmark = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.remove_circle_rounded, color: Colors.white),
    ]),
    backgroundColor: darkblue,
    behavior: SnackBarBehavior.floating,
  );
}
