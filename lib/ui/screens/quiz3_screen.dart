import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import 'package:provider/provider.dart';
import '../../providers/helpers/question_provider.dart';
import '../../providers/helpers/audio_provider.dart';
import '../components/audio_sheet.dart';

class Quiz3Screen extends StatefulWidget {
  Quiz3Screen({Key? key}) : super(key: key);

  @override
  State<Quiz3Screen> createState() => _Quiz3ScreenState();
}

class _Quiz3ScreenState extends State<Quiz3Screen> with WidgetsBindingObserver {
  String teksQuestion = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      qProvider.fetchQuestion('audio_text', 'level1');
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
                                    final aProvider =
                                        Provider.of<AudioProvider>(context,
                                            listen: false);
                                    aProvider.stop();
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
                      Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            decoration: const BoxDecoration(
                                boxShadow: [Styles.boxCardShdStyle],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            width: screenSizes.width - (screenSizes.width / 8),
                            child: Text(
                              qProvider.question?.questionText ?? teksQuestion,
                              style: Styles.bBold14,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Positioned(
                              child: SVG.speakerIcon, left: -10, top: -30),
                        ],
                      ),
                      vSpaceSmall,
                      cardOrange(context,
                          qProvider.question?.correctAnswer ?? teksQuestion),
                      vSpaceSmall,
                      cardWhiteHeader(
                          context, qProvider.question?.options ?? [])
                    ]))));
  }

  Widget cardOrange(BuildContext context, String? teks) {
    var screenSizes = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: lightbrownv2,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: screenSizes.width - (screenSizes.width / 6),
        child: Text(
          teks!.replaceAll('-', '\n'),
          style: Styles.bRegular12,
          textAlign: TextAlign.left,
        ));
  }

  Widget cardWhiteHeader(BuildContext context, List teksAudio) {
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
                        builder: (BuildContext context) {
                          return ModalSheet(
                              teksAudio: teksAudio[0].optionText!);
                        });
                  },
                ),
                SVGBtnIcon(
                  svg: SVG.nextIcon,
                  bgColor: green,
                  splashColor: Colors.teal,
                  onTap: () async {
                    final provider =
                        Provider.of<QuestionProvider>(context, listen: false);
                    await provider.fetchQuestion('audio_text', 'level1',
                        isNextQuestion: true);
                    final aProvider =
                        Provider.of<AudioProvider>(context, listen: false);
                    aProvider.stop();
                  },
                ),
              ],
            )),
      ]),
    ));
  }
}
