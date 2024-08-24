import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  SqliteHelper._privateConstructor();
  static final SqliteHelper instance = SqliteHelper._privateConstructor();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  static const scripts = {
    '1': [
      'CREATE TABLE ideal(id INTEGER PRIMARY KEY, body TEXT,md5 text, crime INTEGER,createdAt STRING,color STRING);',
    ]
  };
  static Future<Database> _initDatabase() async {
    return openDatabase(
      'app.db',
      version: 1,
      onCreate: (db, version) async {
        for (var i = 1; i <= version; i++) {
          List<String>? queries = scripts[i.toString()];
          for (String query in queries!) {
            await db.execute(query);
          }
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          List<String>? queries = scripts[i.toString()];
          for (String query in queries!) {
            await db.execute(query);
          }
        }
      },
    );
  }
}
