class Answer {
  String id;
  String questionId;
  String answerText;
  String submittedAt;

  Answer(
      {required this.id,
      required this.questionId,
      required this.answerText,
      required this.submittedAt});

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
        id: map['id'],
        questionId: map['question_id'],
        answerText: map['answer_text'],
        submittedAt: map['submitted_at']);
  }

  Map toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'answer_text': answerText,
      'submitted_at': submittedAt
    };
  }
}
