import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home-screen');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: Container(
                child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(),
              Column(children: <Widget>[
                Container(
                  width: 250,
                  height: 250,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                Text('Denkschnell', style: Styles.labelTxtStyle),
                vSpaceSmall,
                Text('for beginners', style: Styles.bBold15),
              ]),
              Center(),
            ],
          ),
        ))));
  }
}
