import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import '../../providers/helpers/question_provider.dart';
import '../../providers/helpers/audio_provider.dart';
import '../components/audio_sheet.dart';

class Quiz3Screen extends StatefulWidget {
  const Quiz3Screen({super.key});

  @override
  State<Quiz3Screen> createState() => _Quiz3ScreenState();
}

class _Quiz3ScreenState extends State<Quiz3Screen> with WidgetsBindingObserver {
  String teksQuestion = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      await qProvider.fetchQuestion('audio_text', 'level1');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      final aProvider = Provider.of<AudioProvider>(context, listen: false);
      await qProvider.refreshIDsQuestion();
      aProvider.disposeAll();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qProvider = Provider.of<QuestionProvider>(context);
    final aProvider = Provider.of<AudioProvider>(context);
    var screenSizes = MediaQuery.of(context).size;
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          await qProvider.refreshIDsQuestion().then((_) {
            aProvider.stop();
            Navigator.pop(context);
          });
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
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: SVGBtnIcon(
                                      svg: SVG.homeIcon,
                                      onTap: () async {
                                        await qProvider
                                            .refreshIDsQuestion()
                                            .then((_) {
                                          aProvider.stop();
                                          Navigator.pushNamed(
                                              context, '/menu-screen');
                                        });
                                      },
                                      bgColor: red,
                                      splashColor: Colors.red),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: const Text(
                                      'Rollenspielen',
                                      style: Styles.bBold15,
                                    ))
                              ]),
                          vSpaceMedium,
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(
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
                          vSpaceSmall,
                          cardOrange(
                              context,
                              qProvider.question?.correctAnswer ??
                                  teksQuestion),
                          vSpaceSmall,
                          cardWhiteHeader(
                              context, qProvider.question?.options ?? [])
                        ])))));
  }

  Widget cardOrange(BuildContext context, String? teks) {
    var screenSizes = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(10),
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
                  svg: SVG.audioIcon,
                  bgColor: darkblue,
                  splashColor: Colors.blue,
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
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
                    final aProvider =
                        Provider.of<AudioProvider>(context, listen: false);

                    if (provider.isLastQuestion) {
                      await provider.refreshIDsQuestion().then((_) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarLastAnswers);
                        Navigator.pushNamed(context, '/menu-screen');
                      });
                    } else {
                      await provider
                          .fetchQuestion('audio_text', 'level1',
                              isNextQuestion: true)
                          .then((_) => aProvider.stop());
                    }
                  },
                ),
              ],
            )),
      ]),
    ));
  }
}
