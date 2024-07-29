import 'package:denkschnell/ui/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import '../../providers/helpers/question_provider.dart';
import '../../providers/helpers/backsound_provider.dart';

class Quiz1Screen extends StatefulWidget {
  const Quiz1Screen({super.key});

  @override
  State<Quiz1Screen> createState() => _Quiz1ScreenState();
}

class _Quiz1ScreenState extends State<Quiz1Screen> with WidgetsBindingObserver {
  String teksQuestion = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      await qProvider.fetchQuestion('multiple_choice', 'level1');
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
    final qProvider = Provider.of<QuestionProvider>(context);
    final bsProvider = Provider.of<BacksoundProvider>(context);
    var screenSizes = MediaQuery.of(context).size;
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          await qProvider
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
                                          await qProvider
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
                                      'Grammatik',
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
                                    textAlign: TextAlign.left,
                                  )),
                                  vSpaceXSmall,
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        qProvider.question?.options!.length ??
                                            0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      List<String> char = ['A', 'B', 'C', 'D'];
                                      String option = qProvider.question
                                              ?.options?[index].optionText ??
                                          teksQuestion;
                                      int isBolder = qProvider.question
                                              ?.options?[index].isBolder ??
                                          0;
                                      return Container(
                                          padding: const EdgeInsets.all(5),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
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
                          vSpaceXSmall,
                          cardWhiteOutline(context, 1)
                        ])))));
  }

  Widget cardWhiteOutline(BuildContext context, int questionId) {
    var screenSizes = MediaQuery.of(context).size;
    return Center(
        child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[
          Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: const Color.fromRGBO(0, 0, 0, 0),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: (screenSizes.width / 1.5),
                child: Column(children: <Widget>[
                  const Text(
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
                                  builder: (context) => const ResultScreen(
                                      btnTypeChecked: 'crossIcon')));
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
                                  builder: (context) => const ResultScreen(
                                      btnTypeChecked: 'checkIcon')));
                        },
                      ),
                    ],
                  )
                ]),
              )),
          Positioned(
              bottom: -50,
              child: Image.asset(
                width: 70,
                height: 70,
                'assets/images/question-mark.png',
              ))
        ]));
  }
}
