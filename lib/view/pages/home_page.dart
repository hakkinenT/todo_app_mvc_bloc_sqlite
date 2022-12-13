import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/controller.dart';
import '../../injection_container.dart';
import '../../model/model.dart';
import '../../core/themes/themes.dart';
import '../../core/utils/utils.dart';

import 'add_todo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TodoControllerBloc>()
        ..add(const TodoControllerSubscriptionRequested()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo overview'),
        actions: const [
          ClearAllIconButton(),
          ThemeIconButton(),
          LogoutIconButton()
        ],
      ),
      body: MultiBlocListener(
          listeners: [
            BlocListener<TodoControllerBloc, TodoControllerState>(
                listenWhen: (previous, current) =>
                    previous.todoStatus != current.todoStatus,
                listener: (context, state) {
                  if (state.todoStatus == TodoStatus.failure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(content: Text('Erro')));
                  }
                }),
            BlocListener<TodoControllerBloc, TodoControllerState>(
                listenWhen: (previous, current) =>
                    previous.lastDeletedTodo != current.lastDeletedTodo &&
                    current.lastDeletedTodo != null,
                listener: (context, state) {
                  final deleteTodo = state.lastDeletedTodo!;
                  final messenger = ScaffoldMessenger.of(context);
                  messenger
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('${deleteTodo.title} excluida'),
                      dismissDirection: DismissDirection.startToEnd,
                      padding: const EdgeInsets.all(16),
                      action: SnackBarAction(
                        label: 'Desfazer',
                        onPressed: () {
                          messenger.hideCurrentSnackBar();
                          context
                              .read<TodoControllerBloc>()
                              .add(const TodoControllerUndoDeletionRequested());
                        },
                      ),
                    ));
                }),
          ],
          child: BlocBuilder<TodoControllerBloc, TodoControllerState>(
            builder: (context, state) {
              if (state.todos.isEmpty) {
                if (state.todoStatus == TodoStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.todoStatus != TodoStatus.success) {
                  return const SizedBox();
                } else {
                  const Center(child: Text('Nao há dados cadastrados'));
                }
              }
              return TodoList(
                todos: state.todos,
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddTodoPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  const TodoList({
    Key? key,
    required this.todos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoItem(todo: todos[index]);
          }),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final secondaryColor = theme.colorScheme.secondary;

    final textTheme = theme.textTheme.bodyText2!.copyWith(
      fontWeight: FontWeight.w500,
    );

    final titleStyle = textTheme.copyWith(
      color: secondaryColor,
      fontSize: 16,
    );

    final titleStyleCompleted = textTheme.copyWith(
        color: secondaryColor,
        fontSize: 16,
        decoration: TextDecoration.lineThrough);

    final subtitleStyle = theme.textTheme.subtitle2!
        .copyWith(color: theme.colorScheme.onPrimary.withOpacity(0.4));

    final errorColor = Theme.of(context).errorColor;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 35),
        color: errorColor.withOpacity(0.3),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete,
          size: 27,
          color: errorColor,
        ),
      ),
      onDismissed: (DismissDirection direction) {
        context
            .read<TodoControllerBloc>()
            .add(TodoControllerDeleteRequested(todo: todo));
      },
      child: Card(
        color: theme.colorScheme.primary.withOpacity(0.7),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, addTodoPage, arguments: todo);
          },
          isThreeLine: true,
          trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (bool? isCompleted) {
                if (isCompleted != null) {
                  context.read<TodoControllerBloc>().add(
                      TodoControllerTodoCompletionToggled(
                          isCompleted: isCompleted, todo: todo));
                }
              }),
          title: Text(todo.title,
              style: todo.isCompleted ? titleStyleCompleted : titleStyle),
          subtitle: Text(todo.description,
              overflow: TextOverflow.ellipsis, style: subtitleStyle),
        ),
      ),
    );
  }
}

class ClearAllIconButton extends StatelessWidget {
  const ClearAllIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          BlocProvider.of<TodoControllerBloc>(context)
              .add(const TodoControllerClearAllRequested());
        },
        icon: const Icon(Icons.clear_all));
  }
}

class LogoutIconButton extends StatelessWidget {
  const LogoutIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          BlocProvider.of<AuthenticationControllerBloc>(context)
              .add(const AuthenticationLogoutRequested());
          Navigator.pushNamedAndRemoveUntil(context, appPage, (route) => false);
        },
        icon: const Icon(Icons.logout));
  }
}

class ThemeIconButton extends StatelessWidget {
  const ThemeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        return IconButton(
            onPressed: () {
              BlocProvider.of<ThemeModeCubit>(context).themeChanged();
            },
            icon: state.isDark
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode));
      },
    );
  }
}
