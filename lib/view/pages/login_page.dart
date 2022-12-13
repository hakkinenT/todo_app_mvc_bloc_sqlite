import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/controller.dart';
import '../../core/utils/utils.dart';
import '../../injection_container.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginControllerCubit>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginControllerCubit, LoginControllerState>(
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
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
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
              _RegisterTextButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginControllerCubit, LoginControllerState>(
      builder: (context, state) {
        return StaggerTextFormField(
          startAnimation: 0.0,
          endAnimation: 0.5,
          onChanged: (email) =>
              context.read<LoginControllerCubit>().emailChanged(email),
          validator: (_) => state.emailInput.validate(),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          hintText: 'E-mail',
          labelText: 'E-mail',
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginControllerCubit, LoginControllerState>(
      builder: (context, state) {
        return StaggerTextFormField(
            startAnimation: 0.3,
            endAnimation: 0.7,
            onChanged: (password) =>
                context.read<LoginControllerCubit>().passwordChanged(password),
            validator: (_) => state.passwordInput.validate(),
            textInputAction: TextInputAction.done,
            obscureText: !state.isPasswordVisible,
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
                    .read<LoginControllerCubit>()
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
    return BlocBuilder<LoginControllerCubit, LoginControllerState>(
      builder: (context, state) {
        return StaggerElevatedButton(
            startAnimation: 0.4,
            endAnimation: 0.8,
            onPressed: state.status.isValidated
                ? () {
                    FocusScope.of(context).unfocus();

                    context.read<LoginControllerCubit>().loginWithCredentials();
                  }
                : null,
            child: const Text('Fazer Login'));
      },
    );
  }
}

class _RegisterTextButton extends StatelessWidget {
  const _RegisterTextButton();

  @override
  Widget build(BuildContext context) {
    return StaggerTextButton(
        startAnimation: 0.5,
        endAnimation: 1.0,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, registerPage, ModalRoute.withName(initialPage));
        },
        label: 'Ainda não possui uma conta? Cadastre-se');
  }
}
