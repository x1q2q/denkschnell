import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import 'package:provider/provider.dart';
import '../../providers/helpers/question_provider.dart';
import '../../providers/models/question.dart';

class ResultScreen extends StatefulWidget {
  String btnTypeChecked;
  ResultScreen({Key? key, required this.btnTypeChecked}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      Map<String, dynamic> dataAnswer = {
        "question_id": qProvider.question?.id,
        "answer_text":
            isExcellence(qProvider.question!) ? 'excellence' : 'wrong'
      };
      qProvider.addAnswerChoicesStreams(dataAnswer);
    });
  }

  bool isExcellence(Question? providerQuestion) {
    Question? selectedQ = providerQuestion!;
    if (widget.btnTypeChecked == 'checkIcon') {
      // typical yes
      return selectedQ.isAnswerCorrect(selectedQ.correctAnswer);
    } else {
      // typical no
      return !selectedQ.isAnswerCorrect(selectedQ.correctAnswer);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionProvider>(context, listen: false);

    String resultImage =
        isExcellence(provider.question!) ? 'excellence' : 'wrong';
    String resultString =
        isExcellence(provider.question!) ? 'Excellent!' : 'Wrong!';

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
                          Image.asset('assets/images/${resultImage}.png',
                              height: 70, width: 70),
                          vSpaceXSmall,
                          Text(resultString, style: Styles.excellent)
                        ],
                      )),
                      vSpaceMedium,
                      cardWhiteHeader(context, 1),
                      vSpaceLarge,
                      Text('Denkschnell', style: Styles.labelTxtStyle)
                    ]))));
  }

  Widget cardWhiteHeader(BuildContext context, int questionId) {
    final provider = Provider.of<QuestionProvider>(context);
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
                  onTap: () async {
                    await provider.refreshIDsQuestion();
                    Navigator.popAndPushNamed(context, '/menu-screen');
                  },
                ),
                SVGBtnIcon(
                  svg: SVG.nextIcon,
                  bgColor: green,
                  splashColor: Colors.teal,
                  onTap: () async {
                    if (provider.isLastQuestion) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(Styles.snackBarLastAnswers);
                      await provider.refreshIDsQuestion();
                      String? rAnswer = provider.answerRightResult;
                      String? tAnswer = provider.answerTotalResult;
                      String teks =
                          " You'd been answered right $rAnswer/$tAnswer questions";
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        showCloseIcon: true,
                        duration: const Duration(milliseconds: 5000),
                        content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(Icons.info_outline_rounded,
                                  color: Colors.white),
                              Text(teks, style: Styles.wBold13)
                            ]),
                        backgroundColor: black,
                        dismissDirection: DismissDirection.none,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 100,
                            right: 20,
                            left: 20),
                      ));
                      Navigator.popAndPushNamed(context, '/menu-screen');
                    } else {
                      await provider.fetchQuestion('multiple_choice', 'level1',
                          isNextQuestion: true);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )),
      ]),
    ));
  }
}
