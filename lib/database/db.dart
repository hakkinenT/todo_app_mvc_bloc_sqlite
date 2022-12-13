import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'todos.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_user);
    await db.execute(_todo);
  }

  String get _user => '''
    CREATE TABLE user(
      userId INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL
    );
  ''';

  String get _todo => '''
    CREATE TABLE todo(
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      isCompleted INT NOT NULL,
      userId INTEGER NOT NULL,
      FOREIGN KEY (userId)
        REFERENCES user (userId)
    );
  ''';
}
