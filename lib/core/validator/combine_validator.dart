import 'input_validator.dart';

mixin CombineValidator on InputValidator {
  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }

    return null;
  }
}
