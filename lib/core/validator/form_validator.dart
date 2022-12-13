import 'input_validator.dart';

enum FormStatus {
  initial,
  valid,
  invalid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure;

  bool get isValidated => [
        valid,
        submissionInProgress,
        submissionSuccess,
        submissionFailure
      ].contains(this);

  bool get isSubmissionInProgress => this == submissionInProgress;

  bool get isSubmissionSuccess => this == submissionSuccess;

  bool get isSubmissionFailure => this == submissionFailure;
}

class FormValidator {
  static FormStatus validate({required List<InputValidator> inputs}) {
    final bool isValid = inputs.every((input) => input.valid);

    if (isValid) {
      return FormStatus.valid;
    } else {
      return FormStatus.invalid;
    }
  }
}
