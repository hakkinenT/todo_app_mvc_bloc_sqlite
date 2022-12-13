import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/controller.dart';
import '../../core/utils/utils.dart';
import '../../injection_container.dart';

import '../widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterControllerCubit>(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterControllerCubit, RegisterControllerState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, homePage, (route) => false);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackbar(context, state.errorMessage));
        } else if (state.status.isSubmissionInProgress) {
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              _NameInput(),
              SizedBox(
                height: 16,
              ),
              _EmailInput(),
              SizedBox(
                height: 16,
              ),
              _PasswordInput(),
              SizedBox(
                height: 16,
              ),
              _FormButton(),
              SizedBox(
                height: 24,
              ),
              _LoginTextButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterControllerCubit, RegisterControllerState>(
      builder: (context, state) {
        return StaggerTextFormField(
            startAnimation: 0.0,
            endAnimation: 0.5,
            onChanged: (name) =>
                context.read<RegisterControllerCubit>().nameChanged(name),
            validator: (_) => state.nameInput.validate(),
            textInputAction: TextInputAction.next,
            hintText: 'Nome',
            labelText: 'Nome');
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterControllerCubit, RegisterControllerState>(
      builder: (context, state) {
        return StaggerTextFormField(
          startAnimation: 0.4,
          endAnimation: 0.7,
          onChanged: (email) =>
              context.read<RegisterControllerCubit>().emailChanged(email),
          validator: (_) => state.emailInput.validate(),
          textInputAction: TextInputAction.next,
          hintText: 'E-mail',
          labelText: 'E-mail',
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterControllerCubit, RegisterControllerState>(
      builder: (context, state) {
        return StaggerTextFormField(
            startAnimation: 0.5,
            endAnimation: 0.8,
            onChanged: (password) => context
                .read<RegisterControllerCubit>()
                .passwordChanged(password),
            validator: (_) => state.passwordInput.validate(),
            obscureText: !state.isPasswordVisible,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: state.isPasswordVisible
                  ? const Icon(
                      Icons.visibility,
                    )
                  : const Icon(
                      Icons.visibility_off,
                    ),
              onPressed: () {
                context
                    .read<RegisterControllerCubit>()
                    .passwordVisibilityChanged();
                FocusScope.of(context).unfocus();
              },
            ),
            hintText: 'Senha',
            labelText: 'Senha');
      },
    );
  }
}

class _FormButton extends StatelessWidget {
  const _FormButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterControllerCubit, RegisterControllerState>(
      builder: (context, state) {
        return StaggerElevatedButton(
            startAnimation: 0.7,
            endAnimation: 0.9,
            onPressed: state.status.isValidated
                ? () {
                    FocusScope.of(context).unfocus();

                    context
                        .read<RegisterControllerCubit>()
                        .regiterUserSubmitting();
                  }
                : null,
            child: const Text('Cadastrar'));
      },
    );
  }
}

class _LoginTextButton extends StatelessWidget {
  const _LoginTextButton();

  @override
  Widget build(BuildContext context) {
    return StaggerTextButton(
        startAnimation: 0.8,
        endAnimation: 1.0,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, loginPage, ModalRoute.withName(initialPage));
        },
        label: 'Já possui uma conta? Faça Login');
  }
}
