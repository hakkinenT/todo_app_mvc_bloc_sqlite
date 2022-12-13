part of 'todo_controller_bloc.dart';

abstract class TodoControllerEvent extends Equatable {
  const TodoControllerEvent();

  @override
  List<Object?> get props => [];
}

class TodoControllerTitleChanged extends TodoControllerEvent {
  final String title;
  const TodoControllerTitleChanged({required this.title});

  @override
  List<Object?> get props => [title];
}

class TodoControllerDescriptionChanged extends TodoControllerEvent {
  final String description;
  const TodoControllerDescriptionChanged({required this.description});

  @override
  List<Object?> get props => [description];
}

class TodoControllerSaveRequested extends TodoControllerEvent {
  final int userId;
  const TodoControllerSaveRequested({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class TodoControllerDeleteRequested extends TodoControllerEvent {
  final Todo todo;
  const TodoControllerDeleteRequested({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoControllerClearAllRequested extends TodoControllerEvent {
  const TodoControllerClearAllRequested();
}

class TodoControllerSubscriptionRequested extends TodoControllerEvent {
  const TodoControllerSubscriptionRequested();
}

class TodoControllerTodoCompletionToggled extends TodoControllerEvent {
  final Todo todo;
  final bool isCompleted;

  const TodoControllerTodoCompletionToggled(
      {required this.isCompleted, required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoControllerUndoDeletionRequested extends TodoControllerEvent {
  const TodoControllerUndoDeletionRequested();
}

class TodoControllerEditRequested extends TodoControllerEvent {
  final Todo? initialTodo;
  const TodoControllerEditRequested({this.initialTodo});

  @override
  List<Object?> get props => [initialTodo];
}
