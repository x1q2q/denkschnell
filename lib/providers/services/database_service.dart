import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import '../models/answer.dart';

class DatabaseService {
  static Database? _db;
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, "quizzes.db");

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        ByteData data = await rootBundle.load(url.join("assets", "quizzes.db"));
        List<int> bytes =
            data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
      }
    }

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('');
  }
}
