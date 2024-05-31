import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';

class Quiz3Screen extends StatefulWidget {
  Quiz3Screen({Key? key}) : super(key: key);

  @override
  State<Quiz3Screen> createState() => _Quiz3ScreenState();
}

class _Quiz3ScreenState extends State<Quiz3Screen> {
  String content = '''
  Hallo, Guten Tag! Ich heiße ... & Und wie heißt du?
  Mein Name ist ...
  Woher kommst du?
  Ich komme aus ...
  Was machst du beruflich/studienmäßig?
  Ich studiere in .../arbeitet als ...
  Schön, Sie kennenzulernen!
  Freut mich, dich kennenzulernen!''';

  @override
  Widget build(BuildContext context) {
    String teks = '''
  Führen Sie einen Dialog über das Kennenlernen mit Redemitteln wie im folgenden Beispiel!
 Sie können auch mit anderen Redemitteln kreativ sein!''';
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: SVGBtnIcon(
                                  svg: SVG.homeIcon,
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, '/menu-screen');
                                  },
                                  bgColor: red,
                                  splashColor: Colors.red),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ),
                            Container(
                                child: Text(
                                  'Rollenspielen',
                                  style: Styles.bBold15,
                                ),
                                margin: EdgeInsets.only(right: 10))
                          ]),
                      vSpaceMedium,
                      cardWhite(context, teks, ''),
                      vSpaceSmall,
                      cardOrange(context, content),
                      vSpaceSmall,
                      cardWhiteHeader(context, 1)
                    ]))));
  }

  Widget cardWhite(BuildContext context, String teks, String teks2) {
    var screenSizes = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: screenSizes.width - (screenSizes.width / 8),
          child: Text(
            teks,
            style: Styles.bBold12,
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(child: SVG.speakerIcon, left: -10, top: -30),
      ],
    );
  }

  Widget cardOrange(BuildContext context, String teks) {
    var screenSizes = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: lightbrownv2,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: screenSizes.width - (screenSizes.width / 6),
        child: Text(
          teks,
          style: Styles.bBold12,
          textAlign: TextAlign.left,
        ));
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
                  svg: SVG.audioIcon,
                  bgColor: darkblue,
                  splashColor: Colors.blue,
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32))),
                        context: context,
                        builder: (BuildContext context) => modalSheet(context));
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

  Widget modalSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: greyv2, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'AUDIO 1',
                          style: TextStyle(
                              color: greyv2, fontWeight: FontWeight.normal),
                        )),
                    SVGBtnIcon(
                        svg: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                        bgColor: greyv2,
                        onTap: () {},
                        splashColor: Colors.grey)
                  ],
                )),
            vSpaceSmall,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Say Something ... ',
                  style:
                      TextStyle(color: greyv2, fontWeight: FontWeight.normal),
                ),
                SVGBtnIcon(
                    svg: Icon(Icons.mic, color: Colors.white, size: 30),
                    bgColor: red,
                    onTap: () {},
                    splashColor: Colors.redAccent)
              ],
            )
            // Container(
            //     padding: EdgeInsets.symmetric(horizontal: 5),
            //     width: double.infinity,
            //     height: 60,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: greyv2, width: 2),
            //         borderRadius: BorderRadius.circular(50)),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         Padding(
            //             padding: EdgeInsets.only(left: 15),
            //             child: Text(
            //               'YOUR SUBMISSION',
            //               style: TextStyle(
            //                   color: greyv2, fontWeight: FontWeight.normal),
            //             )),
            //         SVGBtnIcon(
            //             svg: Icon(
            //               Icons.play_arrow,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //             bgColor: greyv2,
            //             onTap: () {},
            //             splashColor: Colors.grey)
            //       ],
            //     )),
          ]),
    );
  }
}
