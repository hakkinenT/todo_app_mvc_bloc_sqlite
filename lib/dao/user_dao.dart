import 'package:flutter_animation/database/db.dart';
import 'package:flutter_animation/model/model.dart';
import 'package:sqflite/sqflite.dart';

abstract class UserDAO {
  Future<int> addUser(User user);
  Future<User?> getUserByEmail(String email);
}

class UserDAOImpl implements UserDAO {
  late Database db;

  @override
  Future<int> addUser(User user) async {
    db = await DB.instance.database;

    var raw = await db.insert("user", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return raw;
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    db = await DB.instance.database;

    var response =
        await db.query("user", where: "email = ?", whereArgs: [email]);

    return response.isNotEmpty ? User.fromJson(response.first) : null;
  }
}
