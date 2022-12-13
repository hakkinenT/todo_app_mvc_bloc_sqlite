import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/controller.dart';
import '../../core/validator/validator.dart';
import '../../injection_container.dart';
import '../../model/model.dart';
import '../widgets/widgets.dart';

class AddTodoPage extends StatelessWidget {
  final Todo? todo;

  const AddTodoPage({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TodoControllerBloc>()
        ..add(TodoControllerEditRequested(initialTodo: todo)),
      child: const AddTodoView(),
    );
  }
}

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoControllerBloc, TodoControllerState>(
      listenWhen: (previous, current) =>
          previous.formStatus != current.formStatus &&
          current.formStatus == FormStatus.submissionSuccess,
      listener: (context, state) {
        if (state.formStatus.isSubmissionSuccess) {
          Navigator.pop(context);
        } else if (state.formStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackbar(context, state.errorMessage!));
        } else if (state.formStatus.isSubmissionInProgress) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              });
        }
      },
      child: const AddTodoForm(),
    );
  }
}

class AddTodoForm extends StatelessWidget {
  const AddTodoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isNewTodo =
        context.select((TodoControllerBloc bloc) => bloc.state.isNewTodo);

    final label = isNewTodo ? 'Cadastrar To do' : 'Editar To do';

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _TitleInput(),
            const SizedBox(
              height: 16,
            ),
            const _DescriptionInput(),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            _FormButton(label: label),
          ],
        ),
      ),
    );
  }
}

class _TitleInput extends StatefulWidget {
  const _TitleInput();

  @override
  State<_TitleInput> createState() => _TitleInputState();
}

class _TitleInputState extends State<_TitleInput> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoControllerBloc, TodoControllerState>(
      buildWhen: (previous, current) =>
          previous.titleInput != current.titleInput,
      builder: (context, state) {
        _titleController.text = state.titleInput.value;
        _titleController.selection =
            TextSelection.collapsed(offset: _titleController.text.length);

        return StaggerTextFormField(
          key: const ValueKey('titleStagger_input'),
          inputKey: const ValueKey('titleInput_todoApp'),
          startAnimation: 0.1,
          endAnimation: 0.5,
          controller: _titleController,
          onChanged: (String title) => context
              .read<TodoControllerBloc>()
              .add(TodoControllerTitleChanged(title: title)),
          validator: (_) => state.titleInput.validate(),
          textInputAction: TextInputAction.next,
          hintText: 'Título',
          labelText: 'Título',
        );
      },
    );
  }
}

class _DescriptionInput extends StatefulWidget {
  const _DescriptionInput();

  @override
  State<_DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<_DescriptionInput> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoControllerBloc, TodoControllerState>(
      builder: (context, state) {
        _descriptionController.text = state.descriptionInput.value;
        _descriptionController.selection =
            TextSelection.collapsed(offset: _descriptionController.text.length);

        return StaggerTextFormField(
          key: const ValueKey('descriptionStagger_input'),
          inputKey: const ValueKey('descriptionInput_TodoApp'),
          startAnimation: 0.4,
          endAnimation: 0.7,
          controller: _descriptionController,
          onChanged: (String description) => context
              .read<TodoControllerBloc>()
              .add(TodoControllerDescriptionChanged(description: description)),
          validator: (_) => state.descriptionInput.validate(),
          textInputAction: TextInputAction.done,
          hintText: 'Descrição',
          labelText: 'Descrição',
          maxLines: 2,
        );
      },
    );
  }
}

class _FormButton extends StatelessWidget {
  final String label;
  const _FormButton({required this.label});

  @override
  Widget build(BuildContext context) {
    final user =
        context.select((AuthenticationControllerBloc bloc) => bloc.state.user);

    final formStatus =
        context.select((TodoControllerBloc bloc) => bloc.state.formStatus);

    return BlocBuilder<TodoControllerBloc, TodoControllerState>(
      builder: (context, state) {
        return StaggerElevatedButton(
            startAnimation: 0.7,
            endAnimation: 1.0,
            onPressed: formStatus.isValidated
                ? () {
                    FocusScope.of(context).unfocus();
                    context
                        .read<TodoControllerBloc>()
                        .add(TodoControllerSaveRequested(userId: user.userId!));
                  }
                : null,
            child: Text(label));
      },
    );
  }
}
