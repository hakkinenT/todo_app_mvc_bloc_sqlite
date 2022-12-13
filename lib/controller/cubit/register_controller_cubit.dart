import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/validator/form_validator.dart';
import '../../model/model.dart';
import '../../repositories/repositories.dart';
import '../../view/forms_inputs/form_inputs.dart';

part 'register_controller_state.dart';

class RegisterControllerCubit extends Cubit<RegisterControllerState> {
  final AuthRepository authRepository;
  RegisterControllerCubit({required this.authRepository})
      : super(const RegisterControllerState());

  void nameChanged(String name) {
    final nameInput = NameInput(value: name);

    emit(state.copyWith(
        nameInput: nameInput,
        status: FormValidator.validate(
            inputs: [nameInput, state.emailInput, state.passwordInput])));
  }

  void emailChanged(String email) {
    final emailInput = EmailInput(value: email);

    emit(state.copyWith(
        emailInput: emailInput,
        status: FormValidator.validate(
            inputs: [state.nameInput, emailInput, state.passwordInput])));
  }

  void passwordChanged(String password) {
    final passwordInput = PasswordInput(value: password);

    emit(state.copyWith(
        passwordInput: passwordInput,
        status: FormValidator.validate(
            inputs: [state.nameInput, state.emailInput, passwordInput])));
  }

  void passwordVisibilityChanged() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> regiterUserSubmitting() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormStatus.submissionInProgress));

    try {
      final user = User(
        name: state.nameInput.value,
        email: state.emailInput.value,
        password: state.passwordInput.value,
      );

      await authRepository.registerUser(user);

      emit(state.copyWith(status: FormStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}
