import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(gradient: Styles.linearGradient),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(),
                  Column(children: <Widget>[
                    Container(
                      width: 300,
                      height: 300,
                      padding: const EdgeInsets.all(10),
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
            ),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/line-3.svg',
            //       height: 220,
            //       width: 220,
            //     ),
            //     left: -10,
            //     top: 0),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/strike-4.svg',
            //       height: 120,
            //       width: 120,
            //     ),
            //     right: 0,
            //     top: 0),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/circle.svg',
            //       height: 120,
            //       width: 120,
            //     ),
            //     left: -50,
            //     top: 250),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/cross-vertical.svg',
            //       height: 90,
            //       width: 90,
            //     ),
            //     right: 50,
            //     top: 200),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/cross-vertical.svg',
            //       height: 90,
            //       width: 90,
            //     ),
            //     left: 50,
            //     bottom: 200),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/circle.svg',
            //       height: 120,
            //       width: 120,
            //     ),
            //     right: -50,
            //     bottom: 250),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/strike-4.svg',
            //       height: 120,
            //       width: 120,
            //     ),
            //     left: 0,
            //     bottom: 0),
            // Positioned(
            //     child: SvgPicture.asset(
            //       'assets/images/line-3.svg',
            //       height: 220,
            //       width: 220,
            //     ),
            //     right: -70,
            //     bottom: -100),
          ],
        )));
  }
}
