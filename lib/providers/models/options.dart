class Options {
  final int? id;
  final int? questionId;
  final String? optionText;
  final int? isBolder;

  Options({this.id, this.questionId, this.optionText, this.isBolder});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question_id': questionId,
      'option_text': optionText,
      'is_bolder': isBolder
    };
  }

  factory Options.fromMap(Map<String, dynamic> maps) {
    return Options(
        id: int.parse(maps['id']),
        questionId: int.parse(maps['question_id']),
        optionText: maps['option_text'],
        isBolder: int.parse(maps['is_bolder']));
  }
}
