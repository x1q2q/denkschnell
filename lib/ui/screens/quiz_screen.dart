import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import '../../ui/components/card_custom.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    String content = '''
    A. gehe
    B. gehen
    C. geht
  ''';
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
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SVGBtnIcon(
                              svg: SVG.homeIcon,
                              onTap: () {},
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
                            margin: EdgeInsets.only(right: 20))
                      ]),
                  vSpaceMedium,
                  cardWhite(
                      context,
                      'Welches Verb passt hier? Ich ___ gerne spazieren.',
                      content),
                  vSpaceXSmall,
                  cardWhiteOutline(context, 1)
                ])));
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
          width: (screenSizes.width / 2) + screenSizes.width / 3,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  teks,
                  style: Styles.bBold12,
                  textAlign: TextAlign.center,
                ),
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
                      onTap: () {},
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
