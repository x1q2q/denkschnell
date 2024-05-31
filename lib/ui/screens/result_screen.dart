import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightblue,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/menu-abc.png',
                          height: 70,
                        ),
                        Container(
                            child: Text(
                              'Grammatik',
                              style: Styles.bBold15,
                            ),
                            margin: EdgeInsets.only(right: 10))
                      ]),
                  vSpaceMedium,
                  Center(
                      child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/excellence.png'),
                      vSpaceXSmall,
                      Text('Excellent!', style: Styles.excellent)
                    ],
                  )),
                  vSpaceMedium,
                  cardWhiteHeader(context, 1),
                  vSpaceLarge,
                  Text('Denkschnell', style: Styles.labelTxtStyle)
                ])));
  }

  Widget cardWhiteHeader(BuildContext context, int questionId) {
    var screenSizes = MediaQuery.of(context).size;
    return Center(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: (screenSizes.width / 1.5),
      child: Column(children: <Widget>[
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: darkbrown,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Text(
              'Weitermachen?',
              style: Styles.wBold15,
              textAlign: TextAlign.center,
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SVGBtnIcon(
                  svg: SVG.homeIcon,
                  bgColor: red,
                  splashColor: Colors.redAccent,
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/menu-screen');
                  },
                ),
                SVGBtnIcon(
                  svg: SVG.nextIcon,
                  bgColor: green,
                  splashColor: Colors.teal,
                  onTap: () {},
                ),
              ],
            )),
      ]),
    ));
  }
}
