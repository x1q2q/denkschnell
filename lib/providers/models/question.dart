import 'options.dart';

class Question {
  final int id;
  final int quizId;
  final String questionText;
  final String questionType;
  final String levelType;
  final String correctAnswer;
  final List<Options>? options;

  Question(
      {required this.id,
      required this.quizId,
      required this.questionText,
      required this.questionType,
      required this.levelType,
      required this.correctAnswer,
      this.options});

  // converting from Question Object into Map<Object>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quiz_id': quizId,
      'question_text': questionText,
      'question_type': questionType,
      'level_type': levelType,
      'correct_answer': correctAnswer,
      'options': options
    };
  }

// extracting a question object from  a map
  factory Question.fromMap(Map<String, dynamic> maps) {
    return Question(
        id: maps['id'],
        quizId: maps['quiz_id'],
        questionText: maps['question_text'],
        questionType: maps['question_type'],
        levelType: maps['level_type'],
        correctAnswer: maps['correct_answer'],
        options: maps['options']);
  }

  bool isAnswerCorrect(String? selectedOption) {
    // check if choices in options (optionText) is same with correct answer on question.
    return options?.firstWhere((option) => option.isBolder == 1).optionText ==
        selectedOption;
  }
}
