import '../utils/constants/constants.dart';

class InputValidatorRule {
  static String? notEmpty(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  static String? validInput(String value, String message) {
    if (value.length < 4) {
      return message;
    } else {
      return null;
    }
  }

  static String? validEmail(String value) {
    if (RegExp(emailRegex).hasMatch(value) == false) {
      return 'Informe um email válido';
    } else {
      return null;
    }
  }

  static String? validPassword(String value) {
    if (value.length < 8) {
      return 'A senha precisa ter no mínimo 8 dígito';
    } else {
      return null;
    }
  }
}
