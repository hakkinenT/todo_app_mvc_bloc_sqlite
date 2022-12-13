import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dao/dao.dart';
import '../model/model.dart';

abstract class TodoService {
  const TodoService();

  Stream<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);

  Future<void> clearAll();
}

class TodoServiceImpl implements TodoService {
  final TodoDAO todoDAO;
  final SharedPreferences sharedPreferences;

  TodoServiceImpl({required this.todoDAO, required this.sharedPreferences}) {
    _init();
  }

  final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(const []);

  void _init() async {
    final todos = await todoDAO.getAllTodo();

    if (todos.isNotEmpty) {
      _todoStreamController.add(todos);
    } else {
      _todoStreamController.add(const []);
    }
  }

  @override
  Future<void> clearAll() async {
    await todoDAO.deleteAllTodo();
    _todoStreamController.add(const []);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);

    if (todoIndex == -1) {
      throw Exception('To do não encontrado');
    } else {
      await todoDAO.deleteTodo(todos[todoIndex]);
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
    }
  }

  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = [..._todoStreamController.value];

    final todoIndex = todos.indexWhere((t) => t.id == todo.id);

    if (todoIndex >= 0) {
      await todoDAO.updateTodo(todo);
      todos[todoIndex] = todo;
    } else {
      await todoDAO.addTodo(todo);
      todos.add(todo);
    }

    _todoStreamController.add(todos);
    return;
  }
}
