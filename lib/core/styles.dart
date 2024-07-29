import 'package:flutter/material.dart';
import 'ui_helper.dart';

class Styles {
  Styles._();
  static const labelTxtStyle = TextStyle(
      fontFamily: 'edo',
      fontWeight: FontWeight.w600,
      color: darkbrown,
      fontSize: 40,
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

  static const wBold12 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 12);

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

  static const bBold14 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w800,
      color: black,
      fontSize: 14);

  static const bBold15 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontSize: 15);

  static const gBold15 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      color: Colors.grey,
      fontSize: 15);

  static const grBold15 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      color: darkblue,
      fontSize: 15);

  static const txtBtn = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w800,
      color: darkblue,
      fontSize: 13);

  static const bBold12 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 12);

  static const bRegular12 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      color: black,
      height: 1.8,
      fontSize: 13);

  static const boxCardShdStyle = BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 4,
      spreadRadius: 0.6,
      color: Colors.black12);

  static ButtonStyle basicBtn = ElevatedButton.styleFrom(
    elevation: 0.5,
    textStyle: wBold15,
    backgroundColor: darkblue,
    minimumSize: const Size(120, 50),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  static const linearGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment(-0.2, -0.5),
    stops: [0.0, 0.5, 0.5, 1],
    colors: [lightbluev2, lightblue, lightbluev2, lightbluev3],
    tileMode: TileMode.repeated,
  );
  static const snackBarSuccessAnswers = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.check_circle, color: Colors.white),
      Text('Quetions answers saved 👍', style: Styles.wBold13)
    ]),
    backgroundColor: darkblue,
    behavior: SnackBarBehavior.floating,
  );
  static const snackBarFailAnswers = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.warning_outlined, color: Colors.white),
      Text('Asnwers is empty!', style: Styles.wBold13)
    ]),
    backgroundColor: Colors.amber,
    behavior: SnackBarBehavior.floating,
  );

  static const snackBarLastAnswers = SnackBar(
    duration: Duration(milliseconds: 1000),
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.info_outline_rounded, color: Colors.white),
      Text(' All Quetions has been asnwered 👍', style: Styles.wBold13)
    ]),
    backgroundColor: green,
    behavior: SnackBarBehavior.floating,
  );
}
