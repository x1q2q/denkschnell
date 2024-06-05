import 'package:flutter/material.dart';
import 'database_helper.dart';
import '../models/question.dart';
import '../models/answer.dart';
import '../../core/string_extension.dart';

class QuestionProvider with ChangeNotifier {
  List<int> _idsQuestion = [];
  List<int> get idQuestions => _idsQuestion;
  List<int> usedIdsQuestion = [];
  Question? _question;
  Question? get question => _question;
  Answer? _answer;
  Answer? get answer => _answer;
  bool _isVisibleAnswer = false;
  bool get isVisibleAnswer => _isVisibleAnswer;
  List<Map<String, dynamic>> listAnswerMultipleChoice = [];
  String? levelEssay; // for forward chaining method use

  List? _allAnswerChoices;
  List? get allAnswerChoice => _allAnswerChoices;

  Future<void> fetchIDQuestions(String typeQuestions, String levelType) async {
    _idsQuestion = await DatabaseHelper()
        .retrieveIDsQuestion('questions', typeQuestions, levelType);
  }

  Future<void> refreshIDsQuestion() async {
    _idsQuestion.clear();
    usedIdsQuestion.clear();
    _isVisibleAnswer = false;
    listAnswerMultipleChoice.clear();
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

    if (_idsQuestion.length == usedIdsQuestion.length) {
      // _question = await DatabaseHelper()
      //     .retrieveQuestionByID('questions', _idsQuestion[0]);
      if (listAnswerMultipleChoice.isNotEmpty) {
        listAnswerMultipleChoice.forEach((elem) async {
          await saveAnswer(elem);
        });
      }
    } else if (_idsQuestion.isNotEmpty) {
      _answer =
          await DatabaseHelper().retrieveAnswerByID(_idsQuestion[indexes]);
      _question =
          await DatabaseHelper().retrieveQuestionByID(_idsQuestion[indexes]);

      usedIdsQuestion.add(_question!.id);
      notifyListeners();
    }
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
    int countWrongAnswersChoices =
        await DatabaseHelper().getCountWrongAnswers();
    levelEssay = countWrongAnswersChoices == 1 || countWrongAnswersChoices == 0
        ? 'level1'
        : countWrongAnswersChoices == 2
            ? 'level2'
            : 'level3';
  }

  Future<void> fetchAnswerChoices() async {
    _allAnswerChoices = await DatabaseHelper().getAnswerChoices();
    notifyListeners();
  }
}
