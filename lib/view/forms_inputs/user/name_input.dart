import '../../../core/validator/validator.dart';

class NameInput extends InputValidator with CombineValidator {
  const NameInput({required super.value});

  @override
  String? validate() {
    final message = combine([
      () => InputValidatorRule.notEmpty(value, 'Informe um nome'),
      () => InputValidatorRule.validInput(value, 'Informe um nome válido')
    ]);

    if (message != null) {
      return message;
    }

    return null;
  }
}
