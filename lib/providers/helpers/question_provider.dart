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

  bool _isLastquestion = false;
  bool get isLastQuestion => _isLastquestion;

  Answer? _answer;
  Answer? get answer => _answer;

  bool _isVisibleAnswer = false;
  bool get isVisibleAnswer => _isVisibleAnswer;

  List<Map<String, dynamic>> listAnswerMultipleChoice = [];
  String? levelEssay; // for forward chaining method use
  String? answerRightResult;
  String? answerTotalResult;

  Future<void> fetchIDQuestions(String typeQuestions, String levelType) async {
    _idsQuestion = await DatabaseHelper()
        .retrieveIDsQuestion('questions', typeQuestions, levelType);
  }

  Future<void> refreshIDsQuestion() async {
    if (listAnswerMultipleChoice.length == _idsQuestion.length) {
      // save an answer multiple choices after completing all quetions
      await DatabaseHelper().deleteAnswerChoices();
      for (var elem in listAnswerMultipleChoice) {
        await saveAnswer(elem);
      }
      List<Map<String, dynamic>> resultAnswers =
          await DatabaseHelper().getAnswerChoices();
      List filteredResult = resultAnswers
          .where((el) => el['answer_text'] == 'excellence')
          .toList();
      answerRightResult = filteredResult.length.toString();
      answerTotalResult = resultAnswers.length.toString();
    }
    _idsQuestion.clear();
    usedIdsQuestion.clear();
    _isVisibleAnswer = false;
    listAnswerMultipleChoice.clear();
    _isLastquestion = false;
    levelEssay = 'level1';
    notifyListeners();
  }

  Future<void> fetchQuestion(String typeQuestion, String levelType,
      {bool isNextQuestion = false}) async {
    _isVisibleAnswer = false;
    if (_idsQuestion.isEmpty) {
      await fetchIDQuestions(typeQuestion, levelType);
    }

    int indexes = (usedIdsQuestion.isEmpty || !isNextQuestion)
        ? 0
        : usedIdsQuestion.length;

    if (_idsQuestion.isNotEmpty) {
      _answer =
          await DatabaseHelper().retrieveAnswerByID(_idsQuestion[indexes]);
      _question =
          await DatabaseHelper().retrieveQuestionByID(_idsQuestion[indexes]);

      usedIdsQuestion.add(_question!.id);
      if (_idsQuestion.length == usedIdsQuestion.length) {
        _isLastquestion = true; // notify that current state is lasted question
      }
    }
    notifyListeners();
  }

  Future<void> setAnswer(Answer? customAnswer) async {
    _answer = customAnswer;
    notifyListeners();
  }

  Future<void> saveAnswer(Map<String, dynamic> answers) async {
    DateTime now = DateTime.now();
    answers['submitted_at'] = now.toString();
    Answer? resultAnswer = await DatabaseHelper().saveAnswers(answers);
    _answer = resultAnswer;
    notifyListeners();
  }

  void triggerAnswer(bool val) {
    _isVisibleAnswer = val;
    notifyListeners();
  }

  void addAnswerChoicesStreams(Map<String, dynamic> data) {
    listAnswerMultipleChoice.add(data);
  }

  Future<void> checkWrongAnswers() async {
    int totalQuestions = 15;
    int countWrongAnswersChoices =
        await DatabaseHelper().getCountWrongAnswers();
    levelEssay = countWrongAnswersChoices == 1 ||
            countWrongAnswersChoices == 0 ||
            countWrongAnswersChoices == 1 ||
            countWrongAnswersChoices == totalQuestions
        ? 'level1'
        : countWrongAnswersChoices == 2
            ? 'level2'
            : 'level3';
    notifyListeners();
  }
}
