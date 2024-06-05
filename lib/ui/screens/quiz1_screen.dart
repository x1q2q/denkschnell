import 'package:denkschnell/ui/screens/result_screen.dart';
import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import 'package:provider/provider.dart';
import '../../providers/helpers/question_provider.dart';
import '../../core/string_extension.dart';

class Quiz1Screen extends StatefulWidget {
  Quiz1Screen({Key? key}) : super(key: key);

  @override
  State<Quiz1Screen> createState() => _Quiz1ScreenState();
}

class _Quiz1ScreenState extends State<Quiz1Screen> with WidgetsBindingObserver {
  String teksQuestion = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      qProvider.fetchQuestion('multiple_choice', 'level1');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qProvider = Provider.of<QuestionProvider>(context);
    var screenSizes = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: Styles.linearGradient,
                ),
                padding: const EdgeInsets.all(10),
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
                                  onTap: () async {
                                    final provider =
                                        Provider.of<QuestionProvider>(context,
                                            listen: false);
                                    await provider.refreshIDsQuestion();
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
                      Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            decoration: const BoxDecoration(
                                boxShadow: [Styles.boxCardShdStyle],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            width: screenSizes.width - (screenSizes.width / 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                      child: Text(
                                    qProvider.question?.questionText ??
                                        teksQuestion,
                                    style: Styles.bBold14,
                                    textAlign: TextAlign.center,
                                  )),
                                  vSpaceXSmall,
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        qProvider.question?.options!.length ??
                                            0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      List<String> char = ['A', 'B', 'C'];
                                      String option = qProvider.question
                                              ?.options?[index].optionText ??
                                          teksQuestion;
                                      int isBolder = qProvider.question
                                              ?.options?[index].isBolder ??
                                          0;
                                      return Container(
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14)),
                                              color: (isBolder == 1)
                                                  ? black
                                                  : Colors.transparent),
                                          child: Text(
                                            '${char[index]}. $option',
                                            style: (isBolder == 1)
                                                ? Styles.wBold12
                                                : Styles.bBold12,
                                            textAlign: TextAlign.left,
                                          ));
                                    },
                                  ),
                                ]),
                          ),
                          Positioned(
                              child: SVG.speakerIcon, left: -10, top: -30),
                        ],
                      ),
                      vSpaceXSmall,
                      cardWhiteOutline(context, 1)
                    ]))));
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultScreen(btnTypeChecked: 'crossIcon')));
                      },
                    ),
                    SVGBtnIcon(
                      svg: SVG.checkIcon,
                      bgColor: green,
                      splashColor: Colors.teal,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultScreen(btnTypeChecked: 'checkIcon')));
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
