import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
import '../model/model.dart';

abstract class TodoDAO {
  Future<List<Todo>> getAllTodo();
  Future<int> addTodo(Todo todo);
  Future<int> updateTodo(Todo todo);
  Future<int> deleteTodo(Todo todo);
  Future<int> deleteAllTodo();
}

class TodoDAOImpl implements TodoDAO {
  late Database db;

  @override
  Future<int> addTodo(Todo todo) async {
    db = await DB.instance.database;

    var raw = await db.insert('todo', todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return raw;
  }

  @override
  Future<int> deleteAllTodo() async {
    db = await DB.instance.database;

    return await db.delete('todo');
  }

  @override
  Future<int> deleteTodo(Todo todo) async {
    db = await DB.instance.database;
    var raw = await db.delete('todo',
        where: "id = ? AND userId = ?", whereArgs: [todo.id, todo.userId]);

    return raw;
  }

  @override
  Future<List<Todo>> getAllTodo() async {
    db = await DB.instance.database;
    var response = await db.query('todo');
    List<Todo> todos = response.map((t) => Todo.fromJson(t)).toList();

    return todos;
  }

  @override
  Future<int> updateTodo(Todo todo) async {
    db = await DB.instance.database;
    var raw = await db.update('todo', todo.toJson(),
        where: "id = ? AND userId = ?", whereArgs: [todo.id, todo.userId]);
    return raw;
  }
}
