import '../../../core/validator/validator.dart';

class EmailInput extends InputValidator with CombineValidator {
  const EmailInput({required super.value});

  @override
  String? validate() {
    final message = combine([
      () => InputValidatorRule.notEmpty(value, 'Informe um email'),
      () => InputValidatorRule.validEmail(value)
    ]);

    if (message != null) {
      return message;
    }

    return null;
  }
}
