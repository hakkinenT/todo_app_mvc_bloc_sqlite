abstract class InputValidator {
  final String value;

  const InputValidator({required this.value});

  bool get invalid => validate() != null;
  bool get valid => validate() == null;

  String? validate();
}
