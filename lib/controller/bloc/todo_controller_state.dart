part of 'todo_controller_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoControllerState extends Equatable {
  final TitleInput titleInput;
  final DescriptionInput descriptionInput;
  final Todo? initialTodo;
  final FormStatus formStatus;
  final TodoStatus todoStatus;
  final List<Todo> todos;
  final Todo? lastDeletedTodo;
  final String? errorMessage;

  const TodoControllerState(
      {this.titleInput = const TitleInput(value: ""),
      this.descriptionInput = const DescriptionInput(value: ""),
      this.formStatus = FormStatus.initial,
      this.todoStatus = TodoStatus.initial,
      this.todos = const [],
      this.errorMessage,
      this.initialTodo,
      this.lastDeletedTodo});

  bool get isNewTodo => initialTodo == null;

  TodoControllerState copyWith(
      {TodoStatus Function()? todoStatus,
      List<Todo> Function()? todos,
      Todo? Function()? lastDeletedTodo,
      TitleInput? titleInput,
      DescriptionInput? descriptionInput,
      FormStatus? formStatus,
      Todo? initialTodo,
      String? errorMessage}) {
    return TodoControllerState(
        todoStatus: todoStatus != null ? todoStatus() : this.todoStatus,
        todos: todos != null ? todos() : this.todos,
        lastDeletedTodo:
            lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
        titleInput: titleInput ?? this.titleInput,
        descriptionInput: descriptionInput ?? this.descriptionInput,
        formStatus: formStatus ?? this.formStatus,
        initialTodo: initialTodo ?? this.initialTodo,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        titleInput,
        descriptionInput,
        formStatus,
        todoStatus,
        todos,
        initialTodo,
        lastDeletedTodo,
        errorMessage
      ];
}
