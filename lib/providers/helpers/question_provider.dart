import 'package:flutter/material.dart';
import 'database_helper.dart';
import '../models/question.dart';

class QuestionProvider with ChangeNotifier {
  List<int> _idsQuestion = [];
  List<int> get idQuestions => _idsQuestion;
  Question? _question;
  Question? get question => _question;
  List<int> usedIdsQuestion = [];

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
      _question = await DatabaseHelper()
          .retrieveQuestionByID('questions', _idsQuestion[indexes]);
      usedIdsQuestion.add(_question!.id);
      notifyListeners();
    }
  }
}

