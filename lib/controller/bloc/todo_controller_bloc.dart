import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/validator/validator.dart';
import '../../model/model.dart';
import '../../repositories/repositories.dart';
import '../../view/forms_inputs/form_inputs.dart';

part 'todo_controller_event.dart';
part 'todo_controller_state.dart';

class TodoControllerBloc
    extends Bloc<TodoControllerEvent, TodoControllerState> {
  final TodoRepository todoRepository;
  TodoControllerBloc({required this.todoRepository})
      : super(const TodoControllerState()) {
    on<TodoControllerTitleChanged>(_onTitleChanged);
    on<TodoControllerDescriptionChanged>(_onDescriptionChanged);
    on<TodoControllerSaveRequested>(_onSaveRequested);
    on<TodoControllerSubscriptionRequested>(_onSubscriptionRequested);
    on<TodoControllerTodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodoControllerDeleteRequested>(_onTodoDeleted);
    on<TodoControllerUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TodoControllerClearAllRequested>(_onClearAllRequested);
    on<TodoControllerEditRequested>(_onEditRequested);
  }

  void _onTitleChanged(
      TodoControllerTitleChanged event, Emitter<TodoControllerState> emit) {
    final titleInput = TitleInput(value: event.title);
    emit(state.copyWith(
        titleInput: titleInput,
        formStatus: FormValidator.validate(
            inputs: [titleInput, state.descriptionInput])));
  }

  void _onDescriptionChanged(TodoControllerDescriptionChanged event,
      Emitter<TodoControllerState> emit) {
    final descriptionInput = DescriptionInput(value: event.description);
    emit(state.copyWith(
        descriptionInput: descriptionInput,
        formStatus: FormValidator.validate(
            inputs: [state.titleInput, descriptionInput])));
  }

  Future<void> _onEditRequested(TodoControllerEditRequested event,
      Emitter<TodoControllerState> emit) async {
    final title = TitleInput(value: event.initialTodo?.title ?? '');
    final description =
        DescriptionInput(value: event.initialTodo?.description ?? '');

    emit(state.copyWith(
        initialTodo: event.initialTodo,
        titleInput: title,
        descriptionInput: description,
        formStatus: FormValidator.validate(inputs: [title, description])));
  }

  Future<void> _onSaveRequested(TodoControllerSaveRequested event,
      Emitter<TodoControllerState> emit) async {
    if (!state.formStatus.isValidated) return;

    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));

    try {
      final todo = (state.initialTodo ?? Todo(title: '')).copyWith(
          title: state.titleInput.value,
          description: state.descriptionInput.value,
          userId: event.userId);

      await todoRepository.saveTodo(todo);

      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          formStatus: FormStatus.submissionFailure,
          errorMessage: e.toString()));
    }
  }

  Future<void> _onSubscriptionRequested(
      TodoControllerSubscriptionRequested event,
      Emitter<TodoControllerState> emit) async {
    emit(state.copyWith(todoStatus: () => TodoStatus.loading));

    await emit.forEach<List<Todo>>(todoRepository.getTodos(),
        onData: (todos) => state.copyWith(
            todoStatus: () => TodoStatus.success, todos: () => todos),
        onError: (_, __) =>
            state.copyWith(todoStatus: () => TodoStatus.failure));
  }

  Future<void> _onTodoCompletionToggled(
      TodoControllerTodoCompletionToggled event,
      Emitter<TodoControllerState> emit) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await todoRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(TodoControllerDeleteRequested event,
      Emitter<TodoControllerState> emit) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    await todoRepository.deleteTodo(event.todo.id);
  }

  Future<void> _onUndoDeletionRequested(
      TodoControllerUndoDeletionRequested event,
      Emitter<TodoControllerState> emit) async {
    assert(state.lastDeletedTodo != null, 'Last deleted todo can not be null');

    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: () => null));
    await todoRepository.saveTodo(todo);
  }

  Future<void> _onClearAllRequested(TodoControllerClearAllRequested event,
      Emitter<TodoControllerState> emit) async {
    await todoRepository.clearAll();
  }
}
