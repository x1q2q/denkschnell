import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import '../../providers/helpers/question_provider.dart';
import '../../providers/helpers/backsound_provider.dart';
import '../components/essay_sheet.dart';

class Quiz2Screen extends StatefulWidget {
  const Quiz2Screen({super.key});

  @override
  State<Quiz2Screen> createState() => _Quiz2ScreenState();
}

class _Quiz2ScreenState extends State<Quiz2Screen> with WidgetsBindingObserver {
  String teksQuestion = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      await qProvider.checkWrongAnswers();
      await qProvider.fetchQuestion(
          'essay_text', qProvider.levelEssay ?? 'level1');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      await qProvider.refreshIDsQuestion();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionProvider>(context);
    final bsProvider = Provider.of<BacksoundProvider>(context);
    var screenSizes = MediaQuery.of(context).size;
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          await provider
              .refreshIDsQuestion()
              .then((_) => Navigator.pop(context));
        },
        child: Scaffold(
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
                                Row(children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: SVGBtnIcon(
                                        svg: SVG.homeIcon,
                                        onTap: () async {
                                          await provider
                                              .refreshIDsQuestion()
                                              .then((_) => Navigator.pushNamed(
                                                  context, '/menu-screen'));
                                        },
                                        bgColor: red,
                                        splashColor: Colors.red),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: SVGBtnIcon(
                                        svg: (!bsProvider.isPlaying)
                                            ? SVG.speakerOff
                                            : SVG.speakerOn,
                                        onTap: () async {
                                          if (!bsProvider.isPlaying) {
                                            await bsProvider.playAudio(
                                                "audios/backsong.mp3");
                                          } else {
                                            await bsProvider.stopAudio();
                                          }
                                        },
                                        bgColor: Colors.amber,
                                        splashColor: darkbrown),
                                  )
                                ]),
                                Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: const Text(
                                      'Landeskunde',
                                      style: Styles.bBold15,
                                    ))
                              ]),
                          vSpaceMedium,
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [Styles.boxCardShdStyle],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            width: screenSizes.width - (screenSizes.width / 8),
                            child: Column(children: <Widget>[
                              Text(
                                provider.question?.questionText ?? teksQuestion,
                                style: Styles.bBold14,
                                textAlign: TextAlign.center,
                              )
                            ]),
                          ),
                          vSpaceXSmall,
                          cardWhiteHeader(context,
                              provider.question?.correctAnswer ?? teksQuestion)
                        ])))));
  }

  Widget cardWhiteHeader(BuildContext context, String teks) {
    final qProvider = Provider.of<QuestionProvider>(context, listen: false);
    var screenSizes = MediaQuery.of(context).size;
    return Center(
        child: Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: (screenSizes.width / 1.5),
      child: Column(children: <Widget>[
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                color: darkbrown,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: const Text(
              'Weitermachen?',
              style: Styles.wBold15,
              textAlign: TextAlign.center,
            )),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SVGBtnIcon(
                  svg: (qProvider.answer != null)
                      ? SVG.modalViewIcon
                      : SVG.modalEditIcon,
                  bgColor:
                      (qProvider.answer != null) ? darkblue : Colors.orange,
                  splashColor: (qProvider.answer != null)
                      ? Colors.blue
                      : Colors.orangeAccent,
                  onTap: () async {
                    await showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32))),
                        context: context,
                        builder: (BuildContext context) => Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: const EssaySheet()));
                  },
                ),
                SVGBtnIcon(
                  svg: SVG.nextIcon,
                  bgColor: green,
                  splashColor: Colors.teal,
                  onTap: () async {
                    if (qProvider.isLastQuestion) {
                      await qProvider.refreshIDsQuestion().then((_) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarLastAnswers);
                        Navigator.pushNamed(context, '/menu-screen');
                      });
                    } else {
                      await qProvider.fetchQuestion('essay_text', 'level1',
                          isNextQuestion: true);
                    }
                  },
                ),
              ],
            )),
      ]),
    ));
  }
}
