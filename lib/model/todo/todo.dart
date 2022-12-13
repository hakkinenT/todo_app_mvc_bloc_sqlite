import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final int? userId;

  Todo(
      {String? id,
      required this.title,
      this.description = '',
      this.isCompleted = false,
      this.userId})
      : assert(id == null || id.isNotEmpty, 'O ID não pode ser nulo'),
        id = id ?? const Uuid().v4();

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'] as String?,
        title: json['title'],
        description: json['description'],
        isCompleted: (json['isCompleted'] as int) == 1 ? true : false,
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isCompleted": isCompleted ? 1 : 0,
      "userId": userId
    };
  }

  Todo copyWith(
      {String? id,
      String? title,
      String? description,
      bool? isCompleted,
      int? userId}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        userId: userId ?? this.userId);
  }

  @override
  String toString() => 'id: $id';
}
