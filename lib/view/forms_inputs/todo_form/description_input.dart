import '../../../core/validator/validator.dart';

class DescriptionInput extends InputValidator with CombineValidator {
  const DescriptionInput({required super.value});

  @override
  String? validate() {
    final message = combine([
      () => InputValidatorRule.notEmpty(value, 'Informe uma descrição'),
      () => InputValidatorRule.validInput(value, 'Informe uma descrição válida')
    ]);

    if (message != null) {
      return message;
    }

    return null;
  }
}
