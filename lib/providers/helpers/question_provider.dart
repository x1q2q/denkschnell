import 'package:flutter/material.dart';
import 'database_helper.dart';
import '../models/question.dart';
import '../models/answer.dart';

class QuestionProvider with ChangeNotifier {
  List<int> _idsQuestion = [];
  List<int> get idQuestions => _idsQuestion;
  List<int> usedIdsQuestion = [];
  Question? _question;
  Question? get question => _question;
  Answer? _answer;
  Answer? get answer => _answer;

  Future<void> fetchIDQuestions(String typeQuestions, String levelType) async {
    _idsQuestion = await DatabaseHelper()
        .retrieveIDsQuestion('questions', typeQuestions, levelType);
  }

  Future<void> refreshIDsQuestion() async {
    _idsQuestion.clear();
    usedIdsQuestion.clear();
    notifyListeners();
  }

  Future<void> fetchQuestion(
      String typeQuestion, String levelType, bool isNextQuestion) async {
    if (_idsQuestion.isEmpty) {
      await fetchIDQuestions(typeQuestion, levelType);
    }

    int indexes = (usedIdsQuestion.isEmpty || !isNextQuestion)
        ? 0
        : usedIdsQuestion.length;

    if (_idsQuestion.length == usedIdsQuestion.length) {
      // _question = await DatabaseHelper()
      //     .retrieveQuestionByID('questions', _idsQuestion[0]);
    } else if (_idsQuestion.isNotEmpty) {
      _answer =
          await DatabaseHelper().retrieveAnswerByID(_idsQuestion[indexes]);
      _question =
          await DatabaseHelper().retrieveQuestionByID(_idsQuestion[indexes]);

      usedIdsQuestion.add(_question!.id);
      notifyListeners();
    }
  }

  Future<void> saveAnswer(Map<String, dynamic> answers) async {
    DateTime now = DateTime.now();
    answers['submitted_at'] = now.toString();
    await DatabaseHelper().saveAnswers(answers);
  }
}
