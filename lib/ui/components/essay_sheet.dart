import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';
import 'my_separator.dart';
import 'package:provider/provider.dart';
import '../../providers/helpers/question_provider.dart';
import 'package:intl/intl.dart';

class EssaySheet extends StatefulWidget {
  const EssaySheet({super.key});

  @override
  State<EssaySheet> createState() => _EssaySheetState();
}

class _EssaySheetState extends State<EssaySheet> {
  final TextEditingController _txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String tglNow(String? timestamp) {
    return DateFormat("hh:mm - dd MMMM", "id_ID")
        .format(DateTime.parse(timestamp!))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    final qProvider = Provider.of<QuestionProvider>(context);
    return (qProvider.answer != null)
        ? Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(
              minHeight: 260,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text('Your Answer', style: Styles.gBold15),
                          Text(
                              "(${tglNow(qProvider.answer?.submittedAt ?? "-")})",
                              style: Styles.gBold15),
                        ],
                      )),
                  vSpaceXSmall,
                  containerTxt(context, qProvider.answer?.answerText ?? "-",
                      greyv2, Styles.bBold15),
                  vSpaceSmall,
                  const MySeparator(height: 1, color: greyv2),
                  TextButton.icon(
                    onPressed: () {
                      qProvider.triggerAnswer(!qProvider.isVisibleAnswer);
                    },
                    icon: Icon(
                        (qProvider.isVisibleAnswer)
                            ? Icons.arrow_circle_down
                            : Icons.arrow_circle_right,
                        color: darkblue),
                    label:
                        const Text('Check Our Answers', style: Styles.txtBtn),
                  ),
                  Visibility(
                      visible: qProvider.isVisibleAnswer,
                      maintainAnimation: true,
                      maintainState: true,
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          opacity: qProvider.isVisibleAnswer ? 1 : 0,
                          child: containerTxt(
                              context,
                              qProvider.question?.correctAnswer ?? "-",
                              darkblue,
                              Styles.grBold15))),
                ]))
        : Container(
            padding: const EdgeInsets.all(20),
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 180,
                    child: TextField(
                      maxLines: 5,
                      controller: _txtController,
                      decoration: InputDecoration(
                          hintText: 'fill the answer ...',
                          hintStyle: const TextStyle(
                              color: greyv2, fontWeight: FontWeight.normal),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(22)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(22))),
                    ),
                  ),
                  ElevatedButton(
                    style: Styles.basicBtn,
                    onPressed: () async {
                      final String teksVal = _txtController.text.toLowerCase();
                      Map<String, dynamic> dataAnswer = {
                        "question_id": qProvider.question?.id,
                        "answer_text": teksVal
                      };
                      if (teksVal.isNotEmpty) {
                        qProvider.saveAnswer(dataAnswer);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarSuccessAnswers);
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarFailAnswers);
                      }
                    },
                    child: const Text('Save'),
                  )
                ]),
          );
  }

  Widget containerTxt(BuildContext context, String? teks, Color borderColor,
      TextStyle styleTxt) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          teks!,
          style: styleTxt,
          textAlign: TextAlign.justify,
        ));
  }
}
