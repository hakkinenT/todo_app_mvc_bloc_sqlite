import '../model/model.dart';
import '../services/services.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getTodos();
  Future<void> saveTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<void> clearAll();
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoService todoService;

  TodoRepositoryImpl({required this.todoService});

  @override
  Future<void> clearAll() => todoService.clearAll();

  @override
  Future<void> deleteTodo(String id) => todoService.deleteTodo(id);

  @override
  Stream<List<Todo>> getTodos() => todoService.getTodos();

  @override
  Future<void> saveTodo(Todo todo) => todoService.saveTodo(todo);
}
