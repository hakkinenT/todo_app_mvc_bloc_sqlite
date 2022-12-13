import '../../../core/validator/validator.dart';

class PasswordInput extends InputValidator with CombineValidator {
  const PasswordInput({required super.value});

  @override
  String? validate() {
    final message = combine([
      () => InputValidatorRule.notEmpty(value, 'Informe uma senha'),
      () => InputValidatorRule.validPassword(value)
    ]);

    if (message != null) {
      return message;
    }

    return null;
  }
}
