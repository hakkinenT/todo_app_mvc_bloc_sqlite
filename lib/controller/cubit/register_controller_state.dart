part of 'register_controller_cubit.dart';

class RegisterControllerState extends Equatable {
  final NameInput nameInput;
  final EmailInput emailInput;
  final PasswordInput passwordInput;
  final bool isPasswordVisible;
  final String errorMessage;
  final FormStatus status;

  const RegisterControllerState(
      {this.nameInput = const NameInput(value: ""),
      this.emailInput = const EmailInput(value: ""),
      this.passwordInput = const PasswordInput(value: ""),
      this.status = FormStatus.initial,
      this.errorMessage = "",
      this.isPasswordVisible = false});

  RegisterControllerState copyWith(
      {NameInput? nameInput,
      EmailInput? emailInput,
      PasswordInput? passwordInput,
      bool? isPasswordVisible,
      String? errorMessage,
      FormStatus? status}) {
    return RegisterControllerState(
        nameInput: nameInput ?? this.nameInput,
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        nameInput,
        emailInput,
        passwordInput,
        isPasswordVisible,
        status,
        errorMessage
      ];
}
