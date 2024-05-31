import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';

class Quiz1Screen extends StatefulWidget {
  Quiz1Screen({Key? key}) : super(key: key);

  @override
  State<Quiz1Screen> createState() => _Quiz1ScreenState();
}

class _Quiz1ScreenState extends State<Quiz1Screen> {
  @override
  Widget build(BuildContext context) {
    String content = '''
    A. gehe
    B. gehen
    C. geht''';
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
                                  'Grammatik',
                                  style: Styles.bBold15,
                                ),
                                margin: EdgeInsets.only(right: 10))
                          ]),
                      vSpaceMedium,
                      cardWhite(
                          context,
                          'Welches Verb passt hier? Ich ___ gerne spazieren.',
                          content),
                      vSpaceXSmall,
                      cardWhiteOutline(context, 1)
                    ]))));
  }

  Widget cardWhite(BuildContext context, String teks, String teks2) {
    var screenSizes = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: screenSizes.width - (screenSizes.width / 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Text(
                  teks,
                  style: Styles.bBold12,
                )),
                (teks2.isNotEmpty)
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          teks2,
                          style: Styles.bBold12,
                          textAlign: TextAlign.left,
                        ))
                    : Center()
              ]),
        ),
        Positioned(child: SVG.speakerIcon, left: -10, top: -30),
      ],
    );
  }

  Widget cardWhiteOutline(BuildContext context, int questionId) {
    var screenSizes = MediaQuery.of(context).size;
    return Center(
        child: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: const Color.fromRGBO(0, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: (screenSizes.width / 1.5),
              child: Column(children: <Widget>[
                Text(
                  'Ist das richtig?',
                  style: Styles.bBold15,
                  textAlign: TextAlign.center,
                ),
                vSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SVGBtnIcon(
                      svg: SVG.crossIcon,
                      bgColor: red,
                      splashColor: Colors.red,
                      onTap: () {},
                    ),
                    SVGBtnIcon(
                      svg: SVG.checkIcon,
                      bgColor: green,
                      splashColor: Colors.teal,
                      onTap: () {
                        Navigator.pushNamed(context, '/result-screen');
                      },
                    ),
                  ],
                )
              ]),
            )),
        Positioned(
            child: Image.asset(
              'assets/images/question-mark.png',
              width: 70,
              height: 70,
            ),
            bottom: -50),
      ],
    ));
  }
}
