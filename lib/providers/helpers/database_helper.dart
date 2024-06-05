import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import '../models/answer.dart';
import '../models/question.dart';
import '../models/options.dart';

class DatabaseHelper {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "quiz.db");

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(url.join("assets", "quiz.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE answers (id INTEGER PRIMARY KEY AUTOINCREMENT, question_id INTEGER, answer_text TEXT, submitted_at TEXT)');
  }

  Future<List> getAllData(String table) async {
    Database db = await database;
    return await db.rawQuery('SELECT * FROM "$table"');
  }

  Future<List> getWhere(String table, String val) async {
    Database db = await database;
    return await db.rawQuery("SELECT * FROM $table WHERE answer_text='$val'");
  }

  Future<List<int>> retrieveIDsQuestion(
      String table, String questionType, String levelType) async {
    Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT id FROM $table WHERE question_type='$questionType' AND level_type='$levelType'");
    List<int> ids = result.map((map) => int.parse(map['id'])).toList();
    return ids;
  }

  Future<Question> retrieveQuestionByID(int questionId) async {
    Database db = await database;
    final List<Map<String, dynamic>> questionMaps =
        await db.rawQuery("SELECT * FROM questions WHERE id='$questionId'");
    final List<Map<String, dynamic>> optionMaps = await db.rawQuery(
        "SELECT * FROM multiple_choice_options WHERE question_id='$questionId'");

    List<Options> dataOption = List.generate(optionMaps.length, (j) {
      return Options.fromMap(optionMaps[j]);
    });

    Map<String, dynamic> data = {
      'id': int.parse(questionMaps[0]['id']),
      'quiz_id': int.parse(questionMaps[0]['quiz_id']),
      'question_text': questionMaps[0]['question_text'],
      'question_type': questionMaps[0]['question_type'],
      'level_type': questionMaps[0]['level_type'],
      'correct_answer': questionMaps[0]['correct_answer'],
      'options': dataOption
    };
    return Question.fromMap(data);
  }

  Future<Answer> saveAnswers(Map<String, dynamic> answers) async {
    Database db = await database;
    await db.transaction((txn) async {
      int insertedId = await txn.rawInsert(
          "INSERT INTO answers  (id, question_id, answer_text, submitted_at) VALUES (?,?,?,?)",
          [
            null,
            answers['question_id'],
            answers['answer_text'],
            answers['submitted_at']
          ]);

      answers['id'] = insertedId;
    });
    return Answer.fromMap(answers);
  }

  Future<Answer?> retrieveAnswerByID(int questionId) async {
    Database db = await database;
    List<Map<String, dynamic>> resultAnswer = await db
        .rawQuery("SELECT * FROM answers WHERE question_id='$questionId'");
    if (resultAnswer.isNotEmpty) {
      return Answer.fromMap(resultAnswer[0]);
    } else {
      return null;
    }
  }

  Future<void> deleteAll(String table) async {
    Database db = await database;
    await db.rawDelete('DELETE FROM $table');
  }

  Future<List> getAnswerChoices() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM answers WHERE answer_text='excellence' OR answer_text='wrong' ORDER BY submitted_at DESC");
    return result;
  }

  Future<int> getCountWrongAnswers() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM answers WHERE answer_text='excellence' OR answer_text='wrong' ORDER BY submitted_at DESC LIMIT 15 ");
    List filteredResult =
        result.where((el) => el['answer_text'] == 'wrong').toList();
    return filteredResult.length;
  }
}
