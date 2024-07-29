import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: Stack(clipBehavior: Clip.none, children: <Widget>[
          Container(
            decoration: const BoxDecoration(gradient: Styles.linearGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(),
                Column(children: <Widget>[
                  Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                  const Text('Denkschnell', style: Styles.labelTxtStyle),
                  vSpaceSmall,
                  const Text('for beginners', style: Styles.bBold15),
                ]),
                const Center(),
              ],
            ),
          )
        ])));
  }
}
