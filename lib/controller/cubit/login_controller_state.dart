part of 'login_controller_cubit.dart';

class LoginControllerState extends Equatable {
  final EmailInput emailInput;
  final PasswordInput passwordInput;
  final bool isPasswordVisible;
  final String errorMessage;
  final FormStatus status;

  const LoginControllerState(
      {this.emailInput = const EmailInput(value: ""),
      this.passwordInput = const PasswordInput(value: ""),
      this.status = FormStatus.initial,
      this.isPasswordVisible = false,
      this.errorMessage = ""});

  LoginControllerState copyWith(
      {EmailInput? emailInput,
      PasswordInput? passwordInput,
      bool? isPasswordVisible,
      String? errorMessage,
      FormStatus? status}) {
    return LoginControllerState(
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status);
  }

  @override
  List<Object> get props =>
      [emailInput, passwordInput, isPasswordVisible, status, errorMessage];
}
