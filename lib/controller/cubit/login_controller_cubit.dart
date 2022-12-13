import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/validator/form_validator.dart';
import '../../model/model.dart';
import '../../repositories/repositories.dart';
import '../../view/forms_inputs/form_inputs.dart';

part 'login_controller_state.dart';

class LoginControllerCubit extends Cubit<LoginControllerState> {
  final AuthRepository authRepository;
  LoginControllerCubit({required this.authRepository})
      : super(const LoginControllerState());

  void emailChanged(String email) {
    final emailInput = EmailInput(value: email);

    emit(state.copyWith(
        emailInput: emailInput,
        status:
            FormValidator.validate(inputs: [emailInput, state.passwordInput])));
  }

  void passwordChanged(String password) {
    final passwordInput = PasswordInput(value: password);

    emit(state.copyWith(
        passwordInput: passwordInput,
        status:
            FormValidator.validate(inputs: [state.emailInput, passwordInput])));
  }

  void passwordVisibilityChanged() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> loginWithCredentials() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      final user = User(
          email: state.emailInput.value, password: state.passwordInput.value);

      await authRepository.login(user);

      emit(state.copyWith(status: FormStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}
