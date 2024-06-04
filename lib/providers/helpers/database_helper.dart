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
    // await db.execute(
    //     'CREATE TABLE answers2 (id INTEGER PRIMARY KEY AUTOINCREMENT, suraId INTEGER, tipe TEXT, surahName TEXT, totalAyat TEXT)');
  }

  Future<List> getAllData(String table) async {
    Database db = await database;
    return await db.rawQuery('SELECT * FROM "$table"');
  }

  Future<List<int>> retrieveIDsQuestion(
      String table, String questionType, String levelType) async {
    Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT id FROM $table WHERE question_type='$questionType' AND level_type='$levelType'");
    List<int> ids = result.map((map) => int.parse(map['id'])).toList();
    return ids;
  }

  Future<Question> retrieveQuestionByID(String table, int questionId) async {
    Database db = await database;
    final List<Map<String, dynamic>> questionMaps =
        await db.rawQuery("SELECT * FROM $table WHERE id='$questionId'");
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
}
