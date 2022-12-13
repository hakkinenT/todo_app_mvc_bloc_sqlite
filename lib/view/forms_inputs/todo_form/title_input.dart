import '../../../core/validator/validator.dart';

class TitleInput extends InputValidator with CombineValidator {
  const TitleInput({required super.value});

  @override
  String? validate() {
    final message = combine([
      () => InputValidatorRule.notEmpty(value, 'Informe um título'),
      () => InputValidatorRule.validInput(value, 'Informe um título válido')
    ]);

    if (message != null) {
      return message;
    }

    return null;
  }
}
